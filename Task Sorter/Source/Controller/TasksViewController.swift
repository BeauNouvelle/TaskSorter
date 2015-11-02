//
//  TasksViewController.swift
//  Task Sorter
//
//  Created by Beau Young on 2/11/2015.
//  Copyright © 2015 Beau Young. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension TasksViewController: UITableViewDataSource {
    
}

extension TasksViewController: UITableViewDelegate {
    
}


