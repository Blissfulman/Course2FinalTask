//
//  YellowViewController.swift
//  Course2FinalTask
//
//  Created by User on 09.08.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import UIKit

class YellowViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        button.tintColor = .brown
    }
    
    @IBAction func tapButton(_ sender: UIButton) {
        show(UserListViewController(), sender: nil)
    }
}
