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

//class PostsProvider: PostsDataProviderProtocol {
//    
//    func feed() -> [Post] {
//        return DataProviders.shared.postsDataProvider.feed()
//    }
//    
//    func post(with postID: Post.Identifier) -> Post? {
//        return DataProviders.shared.postsDataProvider.post(with: postID)
//    }
//    
//    func findPosts(by authorID: User.Identifier) -> [Post]? {
//        return DataProviders.shared.postsDataProvider.findPosts(by: authorID)
//    }
//    
//    func likePost(with postID: Post.Identifier) -> Bool {
//        return DataProviders.shared.postsDataProvider.likePost(with: postID)
//    }
//    
//    func unlikePost(with postID: Post.Identifier) -> Bool {
//        return DataProviders.shared.postsDataProvider.unlikePost(with: postID)
//    }
//    
//    func usersLikedPost(with postID: Post.Identifier) -> [User.Identifier]? {
//        return DataProviders.shared.postsDataProvider.usersLikedPost(with: postID)
//    }
//}
