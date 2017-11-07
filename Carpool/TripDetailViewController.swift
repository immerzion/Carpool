//
//  EventDetailViewController.swift
//  Carpool
//
//  Created by Jess Telmanik on 11/6/17.
//  Copyright © 2017 Immerzion Interactive. All rights reserved.
//

import UIKit
import CarpoolKit


class TripDetailViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeOfDayLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dropOffPickUpButton: UIButton!
    
    
    var trip: Trip!
    var user: User!
    
    // update to tableview instead of uiview
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //idLabel.text = user.name
        eventDescriptionLabel.text = trip.event.description
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        let tripDate = formatter.string(from: trip.event.time)
        // change so it shows set date for particular event
        
        formatter.dateFormat = "h:mm a"
        let tripTime = formatter.string(from: trip.event.time)
        // change so it shows set time for particular event
        
        idLabel.text = "Frank"
        timeOfDayLabel.text = tripTime
        eventDescriptionLabel.text = trip.event.description
        timeLabel.text = tripDate
        locationLabel.text = "location"
        
    }
    
    @IBAction func onPickUpPressed(_ sender: UIButton) {
        alertClaimTrip()
    }
    @IBAction func onDropOffPressed(_ sender: Any) {
        alertClaimTrip()
    }
    
    func alertClaimTrip() {
        
        let message = "Do you want claim this trip?"
        // create the alert
        let alert = UIAlertController(title: "Carpooler", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

