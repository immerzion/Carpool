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
    
    @IBOutlet weak var pickUpButton: UIButton!
    @IBOutlet weak var dropOffButton: UIButton!
    
    
    var trip: Trip!
    var user: User!
    var podLeg: Leg!
    
    // update to tableview instead of uiview
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetButtons()

        let tripDate = trip.event.time.prettyDate
        let tripTime = trip.event.time.prettyTime
        
        idLabel.text = "Frank"
        timeOfDayLabel.text = tripTime
        eventDescriptionLabel.text = trip.event.description
        timeLabel.text = tripDate
        locationLabel.text = "location"
        
        //no longer exists!
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
    
    func claimCurrentLeg(_ pod: Leg) -> Void {
        print(pod)
        
//        switch pod {
//        case trip.pickUp:
//            API.claimPickUp(trip: trip) { (error) in
//                self.disablePickup()
//        }
//        case trip.dropOff:
//            API.claimDropOff(trip: trip) { (error) in
//                self.disableDropoff()
//            }
//        }
        
//        API.claimLeg(leg: pod, trip: trip, completion: { (error) in
//            //TODO
//            if pod == trip.pickUp {
//                disablePickup()
//            }
//            if pod == trip.dropOff {
//                disableDropoff()
//            }
//        })
    }
    
    func resetButtons() {
        resetPickup()
        resetDropoff()
    }
    
    func resetPickup() {
        pickUpButton.setTitle("Pick Up!", for: .normal)
        pickUpButton.isEnabled = true
        //pickUpButton.isHidden = false
    }
    
    func resetDropoff() {
        dropOffButton.setTitle("Drop off!", for: .normal)
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
        podLeg = trip.pickUp
        alertClaimTrip()
    }
    @IBAction func onDropOffPressed(_ sender: UIButton) {
        podLeg = trip.dropOff
        alertClaimTrip()
    }
    
    func alertClaimTrip() {
        
        let message = "Do you want claim this trip?"
        // create the alert
        let alert = UIAlertController(title: "Carpooler", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add action buttons
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            self.claimCurrentLeg(self.podLeg)
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

