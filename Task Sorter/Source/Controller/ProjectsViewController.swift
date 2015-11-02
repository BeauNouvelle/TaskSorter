//
//  ViewController.swift
//  Task Sorter
//
//  Created by Beau Young on 2/11/2015.
//  Copyright © 2015 Beau Young. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension ProjectsViewController: UITableViewDataSource {
    
}

extension ProjectsViewController: UITableViewDelegate {
    
}

