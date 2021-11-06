//
//  ViewController.swift
//  Pictures
//
//  Created by Arwin Oblea on 11/4/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var photosTableView: UITableView! {
        didSet {
            photosTableView.dataSource = self
            photosTableView.delegate = self
        }
    }

    // MARK: - Properties
    private lazy var viewModel: HomeViewModel = {
        return HomeViewModel()
    }()
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = viewModel.title
        viewModel.viewDelegate = self
        
        viewModel.loadPhotos()
    }
}

// MARK: - UITableView DataSource and Delegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        
        let photo = viewModel.photos[indexPath.row]
        cell.textLabel?.text = photo.author
        
        return cell
    }
}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func homeViewModel(_ homeViewModel: HomeViewModel, didReceivePhotos received: Bool) {
        if received == true {
            photosTableView.reloadData()
        } else {
            navigationItem.title = "Could not retrieve list."
        }
    }
    
    func homeViewModel(_ homeViewModel: HomeViewModel, didReceiveError error: Error) {
        print(error)
    }
}

// MARK: - Navigation
extension HomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DetailViewController else { return }
        
        if let indexPath = photosTableView.indexPathForSelectedRow {
            destination.viewModel.photo = viewModel.photos[indexPath.row]
            
        }
    }
}
