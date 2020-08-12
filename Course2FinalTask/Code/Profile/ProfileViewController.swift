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

protocol GestureFromHeaderDelegate: UIViewController {
    func tapFollowersLabel()
    func tapFollowingLabel()
}

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    var photosOfUser = [UIImage]()
    
    // По умолчанию вью отображает данные текущего пользователя
    var user: User = currentUser
    
    convenience init(user: User) {
        self.init()
        self.user = user
    }

    // Получение фотографий постов пользователя
    private func getPhotos(_ user: User) {
        if let filteredPosts = DataProviders.shared.postsDataProvider.findPosts(by: user.id) {
            filteredPosts.forEach { photosOfUser.append($0.image) }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = user.username
        
        photosCollectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "photoCell")
        photosCollectionView.register(UINib(nibName: "HeaderProfileCollectionView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerProfile")

        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        getPhotos(user)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let reusableView = photosCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerProfile", for: indexPath) as! HeaderProfileCollectionView
            reusableView.frame = CGRect(x: 0 , y: 0, width: self.view.frame.width, height: 86)
            reusableView.delegate = self
            reusableView.configure(user: user)
            return reusableView
        default: fatalError("Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosOfUser.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        cell.configure(photosOfUser[indexPath.item])
        return cell
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout, GestureFromHeaderDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = photosCollectionView.bounds.width / 3
        return CGSize(width: size, height: size)
    }
    
    func tapFollowersLabel() {
        if let userList = DataProviders.shared.usersDataProvider.usersFollowedByUser(with: user.id) {
            let followersVC = UserListViewController(userList: userList)
            followersVC.title = "Followers"
            navigationController?.pushViewController(followersVC, animated: true)
        }
    }
    
    func tapFollowingLabel() {
        if let userList = DataProviders.shared.usersDataProvider.usersFollowingUser(with: user.id) {
            let followingVC = UserListViewController(userList: userList)
            followingVC.title = "Following"
            navigationController?.pushViewController(followingVC, animated: true)
        }
    }
}
