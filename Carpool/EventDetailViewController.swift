//
//  EventDetailViewController.swift
//  Carpool
//
//  Created by Jess Telmanik on 11/6/17.
//  Copyright © 2017 Immerzion Interactive. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var labelID: UILabel!
    
    var test = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelID.text = test
    }
    
}
