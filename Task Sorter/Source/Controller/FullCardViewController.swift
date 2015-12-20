//
//  FullCardViewController.swift
//  Task Sorter
//
//  Created by Beau Young on 20/12/2015.
//  Copyright © 2015 Beau Young. All rights reserved.
//

import UIKit

class FullCardViewController: UIViewController {

    @IBOutlet weak var sizeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        sizeLabel.text = title
        sizeLabel.adjustsFontSizeToFitWidth = true
        // Do any additional setup after loading the view.
    }

}
