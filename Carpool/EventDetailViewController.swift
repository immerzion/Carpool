//
//  EventDetailViewController.swift
//  Carpool
//
//  Created by Jess Telmanik on 11/6/17.
//  Copyright © 2017 Immerzion Interactive. All rights reserved.
//

import UIKit
import CarpoolKit
import CoreLocation

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var event: [Event] = []
    var test = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        //idLabel.text = self.event.
//        eventDescriptionLabel.text = self.event.description
//        timeLabel.text = test
//        locationLabel.text = test
    }
    
}
