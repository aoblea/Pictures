//
//  HomeViewModel.swift
//  Pictures
//
//  Created by Arwin Oblea on 11/5/21.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func homeViewModel(_ homeViewModel: HomeViewModel, didReceivePhotos received: Bool)
    func homeViewModel(_ homeViewModel: HomeViewModel, didReceiveError error: Error)
}

class HomeViewModel {
    var photos: [Photo] = []
    
    weak var viewDelegate: HomeViewModelDelegate?
    private let networkManager: NetworkManager
    
    var title: String {
        return "Choose a photo"
    }
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
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
