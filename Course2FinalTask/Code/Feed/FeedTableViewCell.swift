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
    
    var cellPost: Post?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setGestureRecognizers()
    }

    private func setGestureRecognizers() {
        
        // Жест двойного тапа по картринке поста
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
    
    private func setDateAndTime(_ date: Date) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .medium
        dateFormat.timeStyle = .medium
        dateFormat.doesRelativeDateFormatting = true
        return dateFormat.string(from: date as Date)
    }
    
    private func setCountLikesForPost(_ post: Post) -> String {
        if let likes = likesStorage[post.id] {
            return "Likes: " + String(likes.count)
        } else {
            return "Likes: ?"
        }
    }
    
    private func setLikeImageColor(_ post: Post) {
        likeImage.tintColor = post.currentUserLikesThisPost ? .systemBlue : .lightGray
    }
    
    func fillingCell(_ post: Post) {
        avatarImage.image = post.authorAvatar
        authorUsernameLabel.text = post.authorUsername
        createdTimeLabel.text = setDateAndTime(post.createdTime)
        postImage.image = post.image
        likesCountLabel.text = setCountLikesForPost(post)
        setLikeImageColor(post)
        descriptionLabel.text = post.description
        
        cellPost = post
    }
    
    @IBAction func tapPostImage(recognizer: UITapGestureRecognizer) {
        
        // Проверка отсутствия у поста лайка текущего пользователя
        if let post = cellPost {
            guard !feedPosts.first(where: { $0.id == post.id })!.currentUserLikesThisPost else { return }
        }
        
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
        
        // Обработка лайка
        likeUnlikePost()
    }
    
    @IBAction func tapAuthorOfPost(recognizer: UIGestureRecognizer) {        
        guard let post = cellPost else { return }
        if let user = DataProviders.shared.usersDataProvider.user(with: post.author) {
            delegate?.tapAuthorOfPost(user: user)
        }
    }
    
    @IBAction func tapLikesCountLabel(recognizer: UIGestureRecognizer) {
        guard let post = cellPost else { return }
        
        // Создание массива юзеров, лайкнувших пост
        guard let userIDList = likesStorage[post.id] else { return }
        var userList: [User] = []
        userIDList.forEach {
            userList.append(DataProviders.shared.usersDataProvider.user(with: $0)!)
        }
        
        delegate?.tapLikesCountLabel(userList: userList)
    }
    
    // Лайк, либо отмена лайка поста
    private func likeUnlikePost() {
        
        guard let currentPost = cellPost else { return }
                
        // Обновление данных в хранилище лайков и в массиве постов ленты
        for (index, post) in feedPosts.enumerated() {
            if post.id == currentPost.id {
                
                if feedPosts[index].currentUserLikesThisPost {
                    // Удаление текущего пользователя из списка лайкнувших
                    likesStorage[post.id]! = likesStorage[post.id]!.filter { $0.self != currentUser.id }
                } else {
                    // Добавление текущего пользователя в список лайкнувших
                    likesStorage[post.id]!.append(currentUser.id)
                }
                
                // Обновление отображения количества лайков у поста
                likesCountLabel.text = setCountLikesForPost(post)
                
                // Обновление данных о лайке текущего пользователя
                feedPosts[index].currentUserLikesThisPost = !feedPosts[index].currentUserLikesThisPost
                
                // Смена цвета сердечка
                setLikeImageColor(feedPosts[index])
            }
        }
    }
    
    // Действие на тап по сердечку лайка
    @IBAction func tapLikeImage(recognizer: UIGestureRecognizer) {
        likeUnlikePost()
    }
}
