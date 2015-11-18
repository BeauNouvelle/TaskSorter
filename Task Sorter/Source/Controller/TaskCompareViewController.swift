//
//  TaskInputViewController.swift
//  Task Sorter
//
//  Created by Beau Young on 2/11/2015.
//  Copyright © 2015 Beau Young. All rights reserved.
//

import UIKit

class TaskCompareViewController: UIViewController {
    
    // MARK: Properties
    var newNode: NodeTree!
    var rootNode: NodeTree!
    
    @IBOutlet weak var rootNodeButton: UIButton!
    @IBOutlet weak var newNodeButton: UIButton!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootNodeButton.setTitle(rootNode.title, forState: .Normal)
        newNodeButton.setTitle(newNode.title, forState: .Normal)
    }

    // MARK: Actions
    
    // perform traversal if direction is nil, add item and return to add screen.
    // if there is an item, move to next compare screen.
    @IBAction func rootNodeButtonTapped(sender: UIButton) {
        // Go left
        if let root = rootNode.left {
            // new compare screen. set working node to root.
            newCompareViewController(root, newNode: newNode)
        } else {
            // add newNode to empty position. save. dismiss view.
            rootNode.left = newNode
            newNode.parent = rootNode
            NodeManager.sharedManager.saveNodesInSortedArray()
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func newNodeButtonTapped(sender: UIButton) {
        // Go right
        if let root = rootNode.right {
            // new compare screen. set working node to root.
            newCompareViewController(root, newNode: newNode)
        } else {
            // add newNode to empty position. save. dismiss view.
            rootNode.right = newNode
            newNode.parent = rootNode

            NodeManager.sharedManager.saveNodesInSortedArray()
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    /**
     Creates and pushed a new compareViewController onto the navigation stack.
     
     - parameter rootNode: the root node for the next view to compare
     - parameter newNode:  the new node for which we're looking to place somewhere.
     */
    func newCompareViewController(rootNode: NodeTree!, newNode: NodeTree!) {
        let compareViewController = storyboard?.instantiateViewControllerWithIdentifier("TaskCompareViewController") as! TaskCompareViewController
        compareViewController.rootNode = rootNode
        compareViewController.newNode = newNode
        navigationController?.pushViewController(compareViewController, animated: true)
    }
    
}
