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
    func tapAuthorOfPost(currentPost: Post)
    func tapLikesCountLabel()
}

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    @IBOutlet weak var feedTableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedTableView.dataSource = self
        feedTableView.delegate = self
        feedTableView.separatorStyle = .none
                
//        feedTableView.estimatedRowHeight = 144.0
//        feedTableView.rowHeight = UITableView.automaticDimension
    }
    
//    func imgFaild_Click(sender: UITapGestureRecognizer) {
//        let location = sender.location(in: self.feedTableView)
//        let indexPath = self.feedTableView.indexPathForRow(at: location)
//        //do something with the indexPath
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 510
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! FeedTableViewCell
        cell.fillingCell(posts[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension FeedViewController: GestureFromCellDelegate {
    func tapAuthorOfPost(currentPost: Post) {
        
        navigationController?.show(YellowViewController(), sender: nil)
    }
    
    func tapLikesCountLabel() {
        print("Ura")
//        addChild(YellowViewController())
//        view.addSubview(YellowViewController().view)
//        didMove(toParent: self)
//        let vc = YellowViewController()
        
//        show(UserListViewController(frame: self.view.accessibilityFrame), sender: nil)
        
        show(UserListViewController(), sender: nil)
        
//        navigationController?.pushViewController(UserListViewController(), animated: true)
        
//        show(YellowViewController(), sender: nil)
        
    }
}
