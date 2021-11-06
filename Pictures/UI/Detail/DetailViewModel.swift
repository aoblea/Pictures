//
//  DetailViewModel.swift
//  Pictures
//
//  Created by Arwin Oblea on 11/5/21.
//

import Foundation
import UIKit

protocol DetailViewModelDelegate: AnyObject {
    func detailViewModel(_ detailViewModel: DetailViewModel, didFinishImageDownload: Bool)
}

class DetailViewModel {
    
    // MARK: - Properties
    var photo: Photo?
    
    var photoImage: UIImage?

    var photoSize: String {
        return "Height: \(photo?.height.description ?? "No height available.") x Width: \(photo?.width.description ?? "No width available.")"
    }
    var photoAuthor: String {
        return "Author: \(photo?.author ?? "No available author.")"
    }
    
    weak var viewDelegate: DetailViewModelDelegate?
    private let networkManager: NetworkManager
    
    // MARK: - Init
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func loadImage() {
        guard let photo = photo else { return }
        
        networkManager.getImage(urlString: photo.download_url) { result in
            switch result {
            case .success(let image):
                self.photoImage = image
                self.viewDelegate?.detailViewModel(self, didFinishImageDownload: true)
            case .failure(let error):
                print(error)
            }
        }
    }
}
