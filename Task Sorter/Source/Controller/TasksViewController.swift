//
//  TasksViewController.swift
//  Task Sorter
//
//  Created by Beau Young on 2/11/2015.
//  Copyright © 2015 Beau Young. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
    
    var tasks: [NodeTree] {
        return NodeManager.sharedManager.sortedNodes()
    }
    
    //Mark: Propeties
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("View Appeared")
        
        // TODO: Refresh tasks
        // iterate over node tree and add them in order to list.
        tableView.reloadData()
    }

    //MARK: Actions
    
}

// MARK: - UITableViewDataSource
extension TasksViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell", forIndexPath: indexPath) as! TaskTableViewCell
        
        let taskNode = tasks[indexPath.row]
        cell.titleLabel.text = taskNode.title
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension TasksViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let node = tasks[indexPath.row]
        print("Tapped: ", node.title)
    }
    
}


