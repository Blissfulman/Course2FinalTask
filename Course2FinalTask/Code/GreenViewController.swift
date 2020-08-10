//
//  GreenViewController.swift
//  Course2FinalTask
//
//  Created by User on 09.08.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class GreenViewController: UIViewController {
   
   @IBOutlet weak var userListTableView2: UITableView!
   let followers = DataProviders.shared.usersDataProvider.usersFollowedByUser(with: currentUser.id)

   override func viewDidLoad() {
       super.viewDidLoad()
       
       userListTableView2?.dataSource = self
       userListTableView2?.delegate = self
   }
}

extension GreenViewController: UITableViewDataSource, UITableViewDelegate {
    
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
