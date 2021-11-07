//
//  PicturesTests.swift
//  PicturesTests
//
//  Created by Arwin Oblea on 11/4/21.
//

import XCTest

class PicturesTests: XCTestCase {
    // MARK: - Tests for Endpoint
    func test_EndpointURL_isEqual() {
        let sut: Endpoint = .list(page: "1", limit: "50")
        
//        print(sut.url.description)
        
        XCTAssertEqual(sut.url.description, "https://picsum.photos/v2/list?page=1&limit=50")
    }
    
    // MARK: Tests for NetworkManager
    func test_NetworkManager_fetchPhotos_isSuccessfulWithNoErrors() {
        let sut = NetworkManager()
        
        var listOfPhotos: [Photo] = []
        var testNetworkError: NetworkError?
        let expectation = expectation(description: "Expecting a successful result for fetchPhotos")
        
        sut.fetchPhotos { result in
            switch result {
            case .success(let photos):
                
                expectation.fulfill()
                listOfPhotos = photos
                
            case .failure(let error):
                testNetworkError = error
            }
        }
        
        waitForExpectations(timeout: 10)
//        print(listOfPhotos[0])
//        print(listOfPhotos[0].download_url)
//        https://picsum.photos/id/0/5616/3744
        XCTAssertNotNil(listOfPhotos, "listOfPhotos should not be nil.")
        XCTAssertNil(testNetworkError, "testNetworkError should be nil.")
    }
    
    func test_NetworkManager_getImage_isSuccessfulWithNoErrors() {
        let sut = NetworkManager()
        
        var imageResult: UIImage?
        var testNetworkError: NetworkError?
        let expectation = expectation(description: "Expecting a successful result for getImage")
        let testURLString = "https://picsum.photos/id/0/5616/3744" // Taken from listOfPhotos[0].download_url
        
        sut.getImage(urlString: testURLString) { result in
            switch result {
            case .success(let image):
                
                expectation.fulfill()
                imageResult = image
                
            case .failure(let error):
                testNetworkError = error
            }
        }
        
        waitForExpectations(timeout: 10)
        XCTAssertNotNil(imageResult, "imageResult should not be nil.")
        XCTAssertNil(testNetworkError, "testNetworkError should be nil.")
    }
    
    // MARK: - Tests for HomeViewModel + HomeViewModelDelegate
    func test_HomeViewModel_title_isEqual() {
        let sut = HomeViewModel()
        
        XCTAssertEqual(sut.title, "Choose a photographer")
    }
    
    class MockHomeViewControllerDelegate: HomeViewModelDelegate {

        var testDidReceivePhotosResult: Bool?
        var testDidReceiveErrorResult: Error?
        var asyncExpectation: XCTestExpectation?

        func homeViewModel(_ homeViewModel: HomeViewModel, didReceivePhotos received: Bool) {
            guard let expectation = asyncExpectation else {
                XCTFail("Delegate setup is not correct. Missing expectation.")
                return
            }

            testDidReceivePhotosResult = received
            expectation.fulfill()
        }

        func homeViewModel(_ homeViewModel: HomeViewModel, didReceiveError error: Error) {
            testDidReceiveErrorResult = error
        }
    }

    func test_MockHomeViewControllerDelegate_didReceivePhotos_isTrue() {
        let sut = MockHomeViewControllerDelegate()
        let homeViewModel = HomeViewModel()
        homeViewModel.viewDelegate = sut

        let expectation = expectation(description: "Expecting a response from delegate.")
        sut.asyncExpectation = expectation

        homeViewModel.loadPhotos()

        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectations error: \(error)")
            }

            guard let result = sut.testDidReceivePhotosResult else {
                XCTFail("Expecting delegate to be called and return a result.")
                return
            }
            
            XCTAssertTrue(result, "The result to return true.")
        }
    }
    
    // MARK: - Tests for DetailViewModel + DetailViewModelDelegate
    func test_DetailViewModel_photoIsNotNil() {
        // Taken from listOfPhotos[0]
        let selectedPhoto = Photo(id: "0", author: "Alejandro Escamilla", width: 5616, height: 3744, url: "https://unsplash.com/photos/yC-Yzbqy7PY", download_url: "https://picsum.photos/id/0/5616/3744")
        let sut = DetailViewModel()
        sut.photo = selectedPhoto
        
        XCTAssertEqual(sut.photoAuthor, "Author: \(selectedPhoto.author)", "PhotoAuthor string output should be equal.")
        XCTAssertEqual(sut.photoSize, "Height: \(selectedPhoto.height.description) x Width: \(selectedPhoto.width.description)", "PhotoSize string output should be equal.")
    }
    
    func test_DetailViewModel_photoIsNil() {
        let sut = DetailViewModel()
        sut.photo = nil
        
        XCTAssertEqual(sut.photoAuthor, "Author: No available author.", "PhotoAuthor string output should be equal.")
        XCTAssertEqual(sut.photoSize, "Height: No height available. x Width: No width available.", "PhotoSize string output should be equal.")
    }
    
    class MockDetailViewControllerDelegate: DetailViewModelDelegate {
        
        var testDidFinishImageDownloadResult: Bool?
        var asyncExpectation: XCTestExpectation?

        func detailViewModel(_ detailViewModel: DetailViewModel, didFinishImageDownload: Bool) {
            guard let expectation = asyncExpectation else {
                XCTFail("Delegate setup is not correct. Missing expectation.")
                return
            }
            
            testDidFinishImageDownloadResult = didFinishImageDownload
            expectation.fulfill()
        }
    }
    
    func test_MockDetailViewControllerDelegate_didFinishImageDownload_isTrue() {
        let sut = MockDetailViewControllerDelegate()
        // Taken from listOfPhotos[0]
        let selectedPhoto = Photo(id: "0", author: "Alejandro Escamilla", width: 5616, height: 3744, url: "https://unsplash.com/photos/yC-Yzbqy7PY", download_url: "https://picsum.photos/id/0/5616/3744")
        let detailViewModel = DetailViewModel()
        detailViewModel.viewDelegate = sut
        detailViewModel.photo = selectedPhoto
        
        let expectation = expectation(description: "Expecting a response from delegate.")
        sut.asyncExpectation = expectation
        
        detailViewModel.loadImage()
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("waitForExpectations error: \(error)")
            }
            
            guard let result = sut.testDidFinishImageDownloadResult else {
                XCTFail("Expecting the delegate to have a result.")
                return
            }
            
            XCTAssertTrue(result, "Result should return true.")
        }
    }
    
}


