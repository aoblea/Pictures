//
//  HomeViewModel.swift
//  Pictures
//
//  Created by Arwin Oblea on 11/5/21.
//

import Foundation

/// A protocol that allows communication between an object and HomeViewModel.
protocol HomeViewModelDelegate: AnyObject {
    /// A delegate method that takes in a HomeViewModel and sets a received boolean.
    /// ```
    /// self.viewDelegate?.homeViewModel(self, didReceivePhotos: true) // Photos received.
    /// ```
    func homeViewModel(_ homeViewModel: HomeViewModel, didReceivePhotos received: Bool)
    
    /// A delegate method that takes in HomeViewModel and receives an error.
    /// ```
    /// self.viewDelegate?.homeViewModel(self, didReceiveError: error) // Has an error.
    /// ```
    func homeViewModel(_ homeViewModel: HomeViewModel, didReceiveError error: Error)
}

/// An object that holds the business logic and is used to communicate events with HomeViewController.
class HomeViewModel {
    /// Used to hold a list of photos.
    var photos: [Photo] = []
    
    weak var viewDelegate: HomeViewModelDelegate?
    private let networkManager: NetworkManager
    
    /// Holds the title
    ///  - Returns: "Choose a photographer."
    var title: String {
        return "Choose a photographer"
    }
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    /// A method that assigns a success response to a photo array or send a failure response.
    func loadPhotos() {
        networkManager.fetchPhotos { result in
            switch result {
            case .success(let response):
                print("RESPONSE COUNT: \(response.count)")

                self.photos = response
                
                self.viewDelegate?.homeViewModel(self, didReceivePhotos: true)
            case .failure(let error):
                print("LOAD PHOTOS ERROR: \(error)")
                self.viewDelegate?.homeViewModel(self, didReceivePhotos: false)
                self.viewDelegate?.homeViewModel(self, didReceiveError: error)
            }
        }
    }
}
