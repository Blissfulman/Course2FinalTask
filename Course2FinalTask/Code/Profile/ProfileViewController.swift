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

    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    var photosOfUser = [UIImage]()
    
    private func getPhotos(_ user: User) {
        let filteredPosts = DataProviders.shared.postsDataProvider.findPosts(by: user.id)
        if filteredPosts != nil { filteredPosts!.forEach { photosOfUser.append($0.image) } }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosCollectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "photo")
//        photosCollectionView.register(UINib(nibName: "HeaderProfileCollectionView", bundle: nil), forCellWithReuseIdentifier: "headerProfile")
        photosCollectionView.register(UINib(nibName: "HeaderProfileCollectionView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerProfile")

        navigationItem.title = currentUser.username

        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        
        getPhotos(currentUser)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let reusableview = photosCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerProfile", for: indexPath) as! HeaderProfileCollectionView
            
            reusableview.frame = CGRect(x: 0 , y: 0, width: self.view.frame.width, height: 86)
            return reusableview
        default: fatalError("Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosOfUser.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photosCollectionView.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath) as! PhotoCollectionViewCell

        cell.configure(photosOfUser[indexPath.item])
        return cell
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = photosCollectionView.bounds.width / 3
        return CGSize(width: size, height: size)
    }
}
