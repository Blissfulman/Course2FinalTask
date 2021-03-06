//
//  FeedTableViewCell.swift
//  Course2FinalTask
//
//  Created by User on 04.08.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

protocol FeedTableViewCellDelegate: AnyObject {
    func tapAuthorOfPost(user: User)
    func tapLikesCountLabel(userList: [User])
    func updateFeedData()
}

class FeedTableViewCell: UITableViewCell {

    // MARK: - Свойства
    private var cellPostID: Post.Identifier = ""
    weak var delegate: FeedTableViewCellDelegate?
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var authorUsernameLabel: UILabel!
    @IBOutlet weak var createdTimeLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var bigLikeImage: UIImageView!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Методы жизненного цикла
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setGestureRecognizers()
    }
    
    // MARK: - Распознователи жестов
    private func setGestureRecognizers() {
        
        // Жест двойного тапа по картинке поста
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
    
    // MARK: - Настройка элементов ячейки
    func fillingCell(_ post: Post) {
        
        // Запись в переменную ID поста ячейки
        cellPostID = post.id
        
        // Заполнение всех элементов ячейки данными
        avatarImage.image = post.authorAvatar
        authorUsernameLabel.text = post.authorUsername
        createdTimeLabel.text = setDateAndTime(post.createdTime)
        postImage.image = post.image
        likesCountLabel.text = setCountLikesForPost(post)
        setLikeImageColor(post)
        descriptionLabel.text = post.description
    }
    
    private func setDateAndTime(_ date: Date) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .medium
        dateFormat.timeStyle = .medium
        dateFormat.doesRelativeDateFormatting = true
        return dateFormat.string(from: date as Date)
    }
    
    private func setCountLikesForPost(_ post: Post) -> String {
        return "Likes: " + String(post.likedByCount)
    }
    
    private func setLikeImageColor(_ post: Post) {
        likeImage.tintColor = post.currentUserLikesThisPost ? .systemBlue : .lightGray
    }
    
    // MARK: - Действия на жесты
    /// Двойной тап по картинке поста
    @IBAction func tapPostImage(recognizer: UITapGestureRecognizer) {
        
        guard let post = DataProviders.shared.postsDataProvider.post(with: cellPostID) else { return }
        
        // Проверка отсутствия у поста лайка текущего пользователя
        guard !post.currentUserLikesThisPost else { return }
        
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
    
    /// Тап по автору поста
    @IBAction func tapAuthorOfPost(recognizer: UIGestureRecognizer) {
        guard let post = DataProviders.shared.postsDataProvider.post(with: cellPostID) else { return }
        guard let user = DataProviders.shared.usersDataProvider.user(with: post.author) else { return }
        delegate?.tapAuthorOfPost(user: user)
    }
    
    /// Тап по количеству лайков поста
    @IBAction func tapLikesCountLabel(recognizer: UIGestureRecognizer) {
        
        // Создание массива пользователей, лайкнувших пост
        guard let userIDList = DataProviders.shared.postsDataProvider.usersLikedPost(with: cellPostID) else { return }
        var userList = [User]()
        userIDList.forEach {
            if let user = DataProviders.shared.usersDataProvider.user(with: $0) {
                userList.append(user)
            }
        }
        
        // Передача массива пользователей для дальнейшего перехода на экран лайкнувших пост пользователей
        delegate?.tapLikesCountLabel(userList: userList)
    }
    
    /// Тап  по сердечку под постом
    @IBAction func tapLikeImage(recognizer: UIGestureRecognizer) {
        likeUnlikePost()
    }
    
    // MARK: - Обработка лайков
    /// Лайк, либо отмена лайка поста
    private func likeUnlikePost() {
        
        guard let post = DataProviders.shared.postsDataProvider.post(with: cellPostID) else { return }
        
        // Лайк/анлайк поста
        if post.currentUserLikesThisPost {
            let _ = DataProviders.shared.postsDataProvider.unlikePost(with: cellPostID)
        } else {
            let _ = DataProviders.shared.postsDataProvider.likePost(with: cellPostID)
        }
        
        // Получение обновлённого поста
        guard let updatedPost = DataProviders.shared.postsDataProvider.post(with: cellPostID) else { return }
        
        // Обновление отображения количества лайков у поста
        likesCountLabel.text = setCountLikesForPost(updatedPost)
        
        // Смена цвета сердечка
        setLikeImageColor(updatedPost)
        
        // Обновление данных в массиве постов
        delegate?.updateFeedData()
    }
}
