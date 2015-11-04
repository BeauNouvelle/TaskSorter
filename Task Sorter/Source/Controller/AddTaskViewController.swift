//
//  AddTaskViewController.swift
//  Task Sorter
//
//  Created by Beau Young on 2/11/2015.
//  Copyright © 2015 Beau Young. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if NodeManager.sharedManager.hasFirstNode() {
            inputTextField.placeholder = "Add another task..."
        } else {
            inputTextField.placeholder = "Type your first task here..."
        }
    }
    
    // MARK: Actions
    
    @IBAction func nextButtonTapped(sender: UIButton) {
        guard inputTextField.text?.characters.count > 0 else {
            showMissingTextAlert()
            return
        }
        
        if let _ = NodeManager.sharedManager.search(inputTextField.text) {
            showDuplicateAlert()
            return
        }
        
        NodeManager.sharedManager.saveNodesInSortedArray()
        
        if let rootNode = NodeManager.sharedManager.rootNode {
            // move onto compare screen

            let taskCompareViewController = storyboard?.instantiateViewControllerWithIdentifier("TaskCompareViewController") as! TaskCompareViewController
            
            taskCompareViewController.newNode = NodeTree(title: inputTextField.text)
            taskCompareViewController.rootNode = rootNode
            
            navigationController?.pushViewController(taskCompareViewController, animated: true)
        } else { // create new top node. repeat screen with another input.
            NodeManager.sharedManager.createTopNode(inputTextField.text)
            NodeManager.sharedManager.saveNodesInSortedArray()
            let addTaskViewController = storyboard?.instantiateViewControllerWithIdentifier("AddTaskViewController") as! AddTaskViewController
            navigationController?.pushViewController(addTaskViewController, animated: true)
        }
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showMissingTextAlert() {
        let alert = DOAlertController(title: "Hold up!", message: "You have to give a name to your task before moving on.", preferredStyle: DOAlertControllerStyle.Alert)
        let okAction = DOAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func showDuplicateAlert() {
        let alert = DOAlertController(title: "Wait!", message: "You already have a task with that name. Choose a different name.", preferredStyle: DOAlertControllerStyle.Alert)
        let okAction = DOAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }

}

extension AddTaskViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
}