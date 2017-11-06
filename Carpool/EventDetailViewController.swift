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
    
    var trip: Trip!
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        idLabel.text = user.name
        eventDescriptionLabel.text = trip.event.description
        timeLabel.text = trip.event.time
        locationLabel.text = trip.event.location
        
        
//        //idLabel.text = self.event.
//        eventDescriptionLabel.text = self.event.description
//        timeLabel.text = test
//        locationLabel.text = test
    }
    
}
