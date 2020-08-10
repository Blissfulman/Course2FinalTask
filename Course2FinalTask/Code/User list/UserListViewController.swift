//
//  UserListViewController.swift
//  Course2FinalTask
//
//  Created by User on 09.08.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import Foundation
import DataProvider

class UserListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var userListTableView: UITableView!
    let followers = DataProviders.shared.usersDataProvider.usersFollowedByUser(with: currentUser.id)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        userListTableView.register(UINib(nibName: "UserListTableViewCell", bundle: nil), forCellReuseIdentifier: "userCell")
        userListTableView.dataSource = self
        userListTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserListTableViewCell
        if let users = followers {
            cell.fillingCell(users[indexPath.row])
        }
        return cell
    }
}
