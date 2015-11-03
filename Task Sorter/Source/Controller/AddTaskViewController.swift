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
        
    }
    
    // MARK: Actions
    
    @IBAction func nextButtonTapped(sender: UIButton) {
        guard inputTextField.text?.characters.count > 0 else {
            // TODO: Show "Cant be empty" alert.
            return
        }
        
        let taskCompareViewController = storyboard?.instantiateViewControllerWithIdentifier("TaskCompareViewController") as! TaskCompareViewController
        
        // TODO: set task name
        
        navigationController?.pushViewController(taskCompareViewController, animated: true)
    }
    
    
    @IBAction func doneButtonTapped(sender: UIButton) {
        // TODO: Save and do sorting calculation.
        // Base view controller should refresh itself
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}

extension AddTaskViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
}