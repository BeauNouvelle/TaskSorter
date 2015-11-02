//
//  TaskInputViewController.swift
//  Task Sorter
//
//  Created by Beau Young on 2/11/2015.
//  Copyright © 2015 Beau Young. All rights reserved.
//

import UIKit

class CompareTasksViewController: UIViewController {
    
    // TODO: we need to do checking here.
    // if no node exists. this is the first instance of this page. so maybe ask for a name of the project.
    // Ask for name of new node.
    // check tree for existing nodes.
    // If node doesnt exist, add to last position in tree. Move to next screen.
    // If node Does exist, ask if this new one is larger or small than it.
    // If larger, look for next largest node and ask if currently enterered is larger or smaller.
    // If larger, and no node exists. add it to the tree, and move onto next screen to input new node.
    
    // MARK: Properties
    @IBOutlet weak var taskInputTextField: UITextField!
    
    // MARK: Lifecycle

    // MARK: Actions
    
    @IBAction func backButtonTapped(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(sender: UIButton) {
//        let inputViewController = self.storyboard!.instantiateViewControllerWithIdentifier("TaskInputViewController") as! TaskInputViewController
//        navigationController?.pushViewController(inputViewController, animated: true)
    }
    
}
