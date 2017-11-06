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
    //@IBOutlet weak var timeOfDayLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dropOffLabel: UILabel!
    @IBOutlet weak var pickUpLabel: UILabel!
    
    var trip: Trip!

    // update to tableview

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        let tripDate = formatter.string(from: trip.event.time)
        
        idLabel.text = "Frank"
        //timeOfDayLabel.text =
        eventDescriptionLabel.text = trip.event.description
        timeLabel.text = tripDate
        locationLabel.text = "location"
        //dropOffLabel.text = trip.dropOff
    }
    
}
