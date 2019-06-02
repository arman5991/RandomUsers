//
//  ViewController.swift
//  RandomUsers
//
//  Created by Arman Vardanyan on 5/27/19.
//  Copyright © 2019 Arman Vardanyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var searchView: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var searchLoadingBackgroundView: UIView!
    @IBOutlet var searchLoadingIndicator: UIActivityIndicatorView!
    
    private var userViewModels: [UserViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    }
    
    private func initViews() {
        searchView.addDoneCancelToolbar()
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        let itemSize = (self.view.bounds.width - 2) / 2
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func getUsers(users count: Int) {
        RequestManager.getUsersWithCount(count, success: { (users) in
            var viewModels: [UserViewModel] = []
            for user in users {
                viewModels.append(UserViewModel(user: user))
            }
            self.userViewModels = viewModels
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.stopIndicator()
            }
            }, failure: { (error) in
                print(error)
            })
    }
    
    private func startIndicator() {
        searchLoadingBackgroundView.backgroundColor = .lightGray
        searchLoadingBackgroundView.isHidden = false
        searchLoadingIndicator.startAnimating()
    }
    
    private func stopIndicator() {
        searchLoadingBackgroundView.isHidden = true
        searchLoadingIndicator.stopAnimating()
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, let number = Int(text) {
            startIndicator()
            getUsers(users: number)
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: detailViewControllerStoryboardID) as? DetailViewController {
            detailViewController.user = userViewModels[indexPath.row].user
            detailViewController.imageView = userViewModels[indexPath.row].image
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: userCellReuseIdentifier, for: indexPath) as? UserCell else {
            return UserCell()
        }
        
        item.layer.borderColor = UIColor.black.cgColor
        item.layer.borderWidth = 1
        
        let firstName = userViewModels[indexPath.row].user.name.first
        let lastName = userViewModels[indexPath.row].user.name.last
        item.fullNameLabel.text = "\(firstName!) \(lastName!)"
        let viewModel = userViewModels[indexPath.row]
        viewModel.loadUserImage { (image) in
            item.userImageView.image = image
        }
        return item
    }
}
