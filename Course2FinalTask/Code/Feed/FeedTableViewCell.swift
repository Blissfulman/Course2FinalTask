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
    
    weak var delegate: GestureFromCellDelegate?

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var authorUsernameLabel: UILabel!
    @IBOutlet weak var createdTimeLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var bigLikeImage: UIImageView!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var post: Post?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setGestureRecognizers()
    }

    private func setGestureRecognizers() {
        // Жест двоиного тапа по картринке поста
        let postImageGR = UITapGestureRecognizer(target: self, action: #selector(tapPostImage(recognizer:)))
        postImageGR.numberOfTapsRequired = 2
        postImage.isUserInteractionEnabled = true
        postImage.addGestureRecognizer(postImageGR)
        
        // Жест тапа по автору поста (по аватарке)
        let authorAvatarGR = UITapGestureRecognizer(target: self, action: #selector(tapAuthorOfPost(recognizer:)))
        avatarImage.isUserInteractionEnabled = true
        avatarImage.addGestureRecognizer(authorAvatarGR)
        
        // Жест тапа по автору поста (по username)
        let authorUsernameGR = UITapGestureRecognizer(target: self, action: #selector(tapAuthorOfPost(recognizer:)))
        authorUsernameLabel.isUserInteractionEnabled = true
        authorUsernameLabel.addGestureRecognizer(authorUsernameGR)
        
        // Жест тапа по количеству лайков поста
        let likesCountGR = UITapGestureRecognizer(target: self, action: #selector(tapLikesCountLabel(recognizer:)))
        likesCountLabel.isUserInteractionEnabled = true
        likesCountLabel.addGestureRecognizer(likesCountGR)
        
        // Жест тапа по сердечку под постом
        let likeImageGR = UITapGestureRecognizer(target: self, action: #selector(tapLikeImage(recognizer:)))
        likeImage.isUserInteractionEnabled = true
        likeImage.addGestureRecognizer(likeImageGR)
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//    }
    
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
        likeImage.tintColor = post.currentUserLikesThisPost ? .systemBlue : .lightGray
    }
    
    func fillingCell(_ post: Post) {
        avatarImage.image = post.authorAvatar
        authorUsernameLabel.text = post.authorUsername
        createdTimeLabel.text = getDateAndTime(post.createdTime)
        postImage.image = post.image
        likesCountLabel.text = countLikesForPost(post)
        setLikeImage(post)
        descriptionLabel.text = post.description
        
        self.post = post
    }
    
    @IBAction func tapPostImage(recognizer: UITapGestureRecognizer) {
        // Проверка отсутствия у поста лайка текущего пользователя
        guard !post!.currentUserLikesThisPost else { return }
        
        // Анимация большого сердца
        let likeAnimation = CAKeyframeAnimation(keyPath: "opacity")
        likeAnimation.values = [0, 1, 1, 0]
        likeAnimation.keyTimes = [0, 0.1, 0.3, 0.6]
        likeAnimation.timingFunctions = [
            CAMediaTimingFunction(name:CAMediaTimingFunctionName.linear),
            CAMediaTimingFunction(name:CAMediaTimingFunctionName.linear),
            CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeOut)]
        likeAnimation.duration = 0.6
        bigLikeImage.layer.add(likeAnimation, forKey: nil)
    }
    
    @IBAction func tapAuthorOfPost(recognizer: UIGestureRecognizer) {        
        guard let post = post else { return }
        delegate?.tapAuthorOfPost(currentPost: post)
    }
    
    @IBAction func tapLikesCountLabel(recognizer: UIGestureRecognizer) {
        delegate?.tapLikesCountLabel()
    }
    
    @IBAction func tapLikeImage(recognizer: UIGestureRecognizer) {
        likeImage.tintColor = likeImage.tintColor == .systemBlue ? .lightGray : .systemBlue
//        if post!.currentUserLikesThisPost {
//            DataProviders.shared.postsDataProvider.unlikePost(with: post!.id)
//        } else {
//            DataProviders.shared.postsDataProvider.likePost(with: post!.id)
//        }
    }
}
