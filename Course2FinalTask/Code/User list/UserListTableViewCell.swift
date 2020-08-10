//
//  UserListTableViewCell.swift
//  Course2FinalTask
//
//  Created by User on 09.08.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import Foundation
import DataProvider

class UserListTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarUserImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillingCell(_ user: User) {
        avatarUserImage.image = user.avatar
        usernameLabel.text = user.username
    }
}
