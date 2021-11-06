//
//  DetailViewController.swift
//  Pictures
//
//  Created by Arwin Oblea on 11/5/21.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Properties
    lazy var viewModel: DetailViewModel = {
       return DetailViewModel()
    }()
    
    // MARK: - IBOutlets
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            photoImageView.image = viewModel.photoImage
        }
    }

    @IBOutlet weak var sizeLabel: UILabel! {
        didSet {
            sizeLabel.text = viewModel.photoSize
        }
    }
    
    @IBOutlet weak var authorLabel: UILabel! {
        didSet {
            authorLabel.text = viewModel.photoAuthor
        }
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDelegate = self
        viewModel.loadImage()
    }
}

// MARK: - DetailViewModelDelegate
extension DetailViewController: DetailViewModelDelegate {
    func detailViewModel(_ detailViewModel: DetailViewModel, didFinishImageDownload: Bool) {
        if didFinishImageDownload == true {
            self.photoImageView.image = viewModel.photoImage
        }
    }
}
