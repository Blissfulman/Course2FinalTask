//
//  HeaderProfileCollectionView.swift
//  Course2FinalTask
//
//  Created by User on 08.08.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import Foundation
import UIKit
import DataProvider

class HeaderProfileCollectionView: UICollectionReusableView {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImage.image = currentUser.avatar
        avatarImage.layer.cornerRadius = CGFloat(avatarImage.bounds.width / 2)
        fullNameLabel.text = currentUser.fullName
        followersLabel.text = "Followers: " + String(currentUser.followedByCount)
        followingLabel.text = "Followers: " + String(currentUser.followsCount)
    }
    
}
