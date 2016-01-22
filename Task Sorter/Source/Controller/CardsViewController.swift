//
//  CardsViewController.swift
//  Task Sorter
//
//  Created by Beau Young on 17/12/2015.
//  Copyright © 2015 Beau Young. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    var transition = QZCircleSegue()
    
    var fibonacciNumbers: [String] = {
        return ["?", "0", "1/2", "1", "2", "3", "5", "8", "13", "20", "40", "100", "∞"]
    }()
    
    var tshirtSizes: [String] = {
        return ["XS", "S", "M", "L", "XL"]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: "segmentChanged:", forControlEvents: .ValueChanged)
        // Do any additional setup after loading the view.
    }

    // MARK: Actions
    @IBAction func closeButtonTapped(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func segmentChanged(sender: UISegmentedControl) {
        collectionView.reloadData()
    }
    
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue) {
//        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if let selection = sender as? UICollectionViewCell {
            transition.animationChild = selection
            transition.animationColor = UIColor(red: 40.0/255.0, green: 200.0/255.0, blue: 150.0/255.0, alpha: 1.0)
            
            if let label = sender?.viewWithTag(11) as? UILabel {
                transition.labelText = label.text
            }
            
            let toViewController = segue.destinationViewController as! FullCardViewController
            toViewController.title = (selection.viewWithTag(11) as! UILabel).text
                self.transition.fromViewController = self
            self.transition.toViewController = toViewController
            toViewController.transitioningDelegate = transition
        }
    }
}

extension CardsViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            return tshirtSizes.count
        } else {
            return fibonacciNumbers.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CELL", forIndexPath: indexPath)
        
        if let label = cell.viewWithTag(11) as? UILabel {
            label.textAlignment = .Center
            label.textColor = UIColor.whiteColor()
            label.font = UIFont.systemFontOfSize(50)
            
            if segmentedControl.selectedSegmentIndex == 0 {
                label.text = tshirtSizes[indexPath.row]
            } else {
                label.text = fibonacciNumbers[indexPath.row]
            }
            label.adjustsFontSizeToFitWidth = true
        }
        return cell
    }

}

//extension CardsViewController: UICollectionViewDelegate {
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let selection = collectionView.cellForItemAtIndexPath(indexPath)
//        performSegueWithIdentifier("fullCardSegue", sender: selection)
//    }
//}
