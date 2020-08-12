//
//  MainViewController.swift
//  Course2FinalTask
//
//  Created by User on 22.07.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import Foundation
import UIKit
import DataProvider

protocol GestureFromCellDelegate: UIViewController {
    func tapAuthorOfPost(user: User)
    func tapLikesCountLabel(userList: [User])
}

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    @IBOutlet weak var feedTableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedTableView.dataSource = self
        feedTableView.delegate = self
        feedTableView.separatorStyle = .none
        
        // Заполнение хранилища лайков данными
        feedPosts.forEach { likesStorage[$0.id] = DataProviders.shared.postsDataProvider.usersLikedPost(with: $0.id) }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! FeedTableViewCell
        cell.fillingCell(feedPosts[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension FeedViewController: GestureFromCellDelegate {
    
    func tapAuthorOfPost(user: User) {
        guard let profileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else { return }
        profileVC.user = user
        show(profileVC, sender: nil)
    }
    
    func tapLikesCountLabel(userList: [User]) {
        let likesCV = UserListViewController(userList: userList)
        likesCV.title = "Likes"
        show(likesCV, sender: nil)
    }
}
