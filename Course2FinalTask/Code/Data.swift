//
//  PostsProvider.swift
//  Course2FinalTask
//
//  Created by User on 04.08.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import Foundation
import DataProvider

/// Массив постов ленты
var feedPosts = DataProviders.shared.postsDataProvider.feed()

/// Текущий пользователь
let currentUser = DataProviders.shared.usersDataProvider.currentUser()

/// Словарь, хранящий юзеров, лайкнувших посты ленты (хранилище лайков)
var likesStorage: [Post.Identifier : [User.Identifier]] = [:]
