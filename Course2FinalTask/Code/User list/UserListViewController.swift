//
//  YellowViewController.swift
//  Course2FinalTask
//
//  Created by User on 09.08.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit
import DataProvider

class UserListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    var userList: [User] = []
    
    convenience init(userList: [User]) {
        self.init()
        self.userList = userList
    }
    
    private lazy var userListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private func setupUI() {
        view.addSubview(userListTableView)
    }
    
    private func setupConstraints() {
        userListTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        userListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        userListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        userListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        userListTableView.dataSource = self
        userListTableView.delegate = self
    }
    
    // Снятие выделения с ячейки при возврате на вью
    override func viewDidAppear(_ animated: Bool) {
        guard let selectedRow = userListTableView.indexPathForSelectedRow else { return }
        userListTableView.deselectRow(at: selectedRow, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.imageView?.image = userList[indexPath.row].avatar
        cell.textLabel?.text = userList[indexPath.row].fullName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if #available(iOS 13.0, *) {
            goToUserProfileVC(user: userList[indexPath.row])
        } else {
            fatalError("Not available on iOS version below 13.0")
        }
    }
    
    @available(iOS 13.0, *)
    func goToUserProfileVC(user: User) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let profileVC = storyboard.instantiateViewController(identifier: "ProfileViewController") as? ProfileViewController else { return }
        profileVC.user = user
        show(profileVC, sender: nil)
    }
}
