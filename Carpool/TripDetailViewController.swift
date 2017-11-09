//
//  TripDetailViewController.swift
//  Carpool
//
//  Created by Jess Telmanik on 11/6/17.
//  Copyright © 2017 Immerzion Interactive. All rights reserved.
//

import UIKit
import CarpoolKit
import MapKit


class TripDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var pickUpButton: UIButton!
    @IBOutlet weak var dropOffButton: UIButton!
    
    
    var trip: Trip!
    var user: User!
    var podLeg: Leg!
    var childNames = ""
    //var location = ""
    //var description = ""
    //var time = ""
    
    //jess
    
    let savannah = CLLocation(latitude: 32.076176, longitude: -81.088371)
    
    
    // update to tableview instead of uiview?
    //Add ability to cancel a confirmation, popup window for reason why cancellation is needed.
    //Send notification to affected parents and update the database.
    
    //child mode - lets kids know who is picking them up - stretch goal security feature.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetButtons()
        
        let tripDate = trip.event.time.prettyDate
        let tripTime = trip.event.time.prettyTime
        
        for child in trip.children {
            childNames += ", " + child.name
        }
        
        nameLabel.text = childNames
        eventDescriptionLabel.text = trip.event.description
        dateLabel.text = tripDate
        timeLabel.text = tripTime
        locationLabel.text = "need to geocode" //trip.event.clLocation
        
        
        if trip.pickUp != nil {
            disablePickup()
        } else {
            resetPickup()
        }
        
        if trip.dropOff != nil {
            disableDropoff()
        } else {
            resetDropoff()
        }
    }
    
    func resetButtons() {
        resetPickup()
        resetDropoff()
    }
    
    func resetPickup() {
        pickUpButton.setTitle("Pick Up", for: .normal)
        pickUpButton.isEnabled = true
        //pickUpButton.isHidden = false
    }
    
    func resetDropoff() {
        dropOffButton.setTitle("Drop Off", for: .normal)
        dropOffButton.isEnabled = true
        //dropOffButton.isHidden = true
    }
    
    func disablePickup() {
        pickUpButton.setTitle("Pickup has been scheduled", for: .normal)
        pickUpButton.isEnabled = false
    }
    
    func disableDropoff() {
        dropOffButton.setTitle("Drop off has been scheduled", for: .normal)
        dropOffButton.isEnabled = false
    }
    
    
    @IBAction func onPickUpPressed(_ sender: UIButton) {
        confirmPickUp()
    }
    @IBAction func onDropOffPressed(_ sender: UIButton) {
        confirmDropOff()
    }
    
    func confirmPickUp() {
        
        let message = "Do you want to pickup \(childNames)?" //from location
        // create the alert
        let alert = UIAlertController(title: "Carpooler", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add action buttons
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            API.claimPickUp(trip: self.trip, completion: { (error) in
                self.disablePickup()
            })
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func confirmDropOff() {
        
        let message = "Do you want to drop off \(childNames)?" //at location
        // create the alert
        let alert = UIAlertController(title: "Carpooler", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add action buttons
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            API.claimDropOff(trip: self.trip, completion: { (error) in
                self.disableDropoff()
            })
            
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

