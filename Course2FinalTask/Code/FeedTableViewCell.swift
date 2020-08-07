//
//  FeedTableViewCell.swift
//  Course2FinalTask
//
//  Created by User on 04.08.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var authorUsernameLabel: UILabel!
    @IBOutlet weak var createdTimeLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var bigLikeImage: UIImageView!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func getDateAndTime(_ date: Date) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .medium
        dateFormat.timeStyle = .medium
        dateFormat.doesRelativeDateFormatting = true
        return dateFormat.string(from: date as Date)
    }
    
    private func countLikesForPost(_ post: Post) -> String {
        return "Likes: " + String(post.likedByCount)
    }
    
    private func setLikeImage(_ post: Post) {
        if post.currentUserLikesThisPost {
            likeImage.tintColor = .systemBlue
        } else {
            likeImage.tintColor = .lightGray
        }
    }
    
    func fillingCell(_ post: Post) {
        avatarImage.image = post.authorAvatar
        authorUsernameLabel.text = post.authorUsername
        createdTimeLabel.text = getDateAndTime(post.createdTime)
        postImage.image = post.image
        likesCountLabel.text = countLikesForPost(post)
        setLikeImage(post)
        descriptionLabel.text = post.description
    }
    
    
}
