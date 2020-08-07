//
//  PostsProvider.swift
//  Course2FinalTask
//
//  Created by User on 04.08.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import Foundation
import DataProvider

let posts = DataProviders.shared.postsDataProvider.feed()
let currentUser = DataProviders.shared.usersDataProvider.currentUser()

//    var followers: [(userID: User.Identifier, followingID: User.Identifier)]
