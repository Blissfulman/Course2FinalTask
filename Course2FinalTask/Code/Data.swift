//
//  PostsProvider.swift
//  Course2FinalTask
//
//  Created by User on 04.08.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import Foundation
import DataProvider

// Массив постов ленты
var feedPosts = DataProviders.shared.postsDataProvider.feed()

// Текущий пользователь
let currentUser = DataProviders.shared.usersDataProvider.currentUser()

// Словарь, хранящий юзеров, лайкнувших посты ленты (хранилище лайков)
var likesStorage: [Post.Identifier : [User.Identifier]] = [:]

//let followingUsers = DataProviders.shared.usersDataProvider.usersFollowingUser(with: currentUser.id)
//let followedUsers = DataProviders.shared.usersDataProvider.usersFollowedByUser(with: currentUser.id)
//let likes = [DataProviders.shared.postsDataProvider.]
//    var followers: [(userID: User.Identifier, followingID: User.Identifier)]
