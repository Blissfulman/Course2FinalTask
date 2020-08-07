//
//  User.swift
//  Course2FinalTask
//
//  Created by User on 04.08.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import Foundation
import UIKit
import DataProvider

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    var photosOfUser = [UIImage]()
    
    private func getPhotos(_ user: User) {
        let filteredPosts = DataProviders.shared.postsDataProvider.findPosts(by: user.id)
        if filteredPosts != nil { filteredPosts!.forEach { photosOfUser.append($0.image) } }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = currentUser.username
        avatarImage.image = currentUser.avatar
        avatarImage.layer.cornerRadius = 35
        fullNameLabel.text = currentUser.fullName
        followersLabel.text = "Followers: " + String(currentUser.followedByCount)
        followingLabel.text = "Followers: " + String(currentUser.followsCount)
        
//        photosCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        
        getPhotos(currentUser)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosOfUser.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as! PhotoCollectionViewCell

        cell.configure(photosOfUser[indexPath.item])
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: photosCollectionView.bounds.size.width/3, height: photosCollectionView.bounds.size.width/3)
//    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: photosCollectionView.bounds.size.width/3, height: photosCollectionView.bounds.size.width/3)
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
