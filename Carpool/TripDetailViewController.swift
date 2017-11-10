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
    @IBOutlet weak var cancelPickUpButton: UIButton!
    @IBOutlet weak var cancelDropOffButton: UIButton!
    
    
    var trip: Trip!
    var user: User!
    var podLeg: Leg!
    var childNames = ""
    
    let savannah = CLLocation(latitude: 32.076176, longitude: -81.088371)
    
    
    // update to tableview instead of uiview?
    //Add ability to cancel a confirmation, popup window for reason why cancellation is needed.
    //Send notification to affected parents and update the database.
    
    //child mode - lets kids know who is picking them up - stretch goal security feature.
    
    //        trip.pickUp?.driver
    //        trip.dropOff?.driver
    //
    //        trip.event.owner.name
    //        trip.event.owner.isMe
    //        trip.event.description
    //        trip.event.time
    //        trip.event.endTime
    //        trip.event.clLocation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetButtons()
        
//        if trip.pickUp.driver == me
//        show cancelButtons
        
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
        
        let tripDate = trip.event.time.prettyDate
        let tripTime = trip.event.time.prettyTime
        
        for child in trip.children {
            childNames += ", " + child.name
        }
        
        nameLabel.text = childNames
        eventDescriptionLabel.text = trip.event.description
        dateLabel.text = tripDate
        timeLabel.text = tripTime
        //locationLabel.text = trip.event.clLocation?.mkName
        
        let geocoder = CLGeocoder()

        if let tripLocation = trip.event.clLocation {
            geocoder.reverseGeocodeLocation(tripLocation, completionHandler: onReverseGeocodeCompleted)
        } else {
            locationLabel.text = ""
        }

    }

    func onReverseGeocodeCompleted(placemarks: [CLPlacemark]?, error: Error?) {
        if let locationName = placemarks?.first?.name {
            locationLabel.text = locationName
        } else {
            locationLabel.text = ""
        }
   }
    
    func resetButtons() {
        resetPickup()
        resetDropoff()
    }
    
    func resetPickup() {
        pickUpButton.setTitle("Pick Up", for: .normal)
        pickUpButton.isEnabled = true
        cancelPickUpButton.isHidden = true
    }
    
    func resetDropoff() {
        dropOffButton.setTitle("Drop Off", for: .normal)
        dropOffButton.isEnabled = true
        cancelDropOffButton.isHidden = true
    }
    
    func disablePickup() {
        //if trip.pickUp.driver == me
        //change pickup driver to "you"
        
        pickUpButton.setTitle("\(trip.pickUp!.driver) will pickup \(childNames)", for: .normal)
        pickUpButton.isEnabled = false
        cancelPickUpButton.isHidden = false
    }
    
    func disableDropoff() {
        dropOffButton.setTitle("\(trip.dropOff!.driver) will drop off \(childNames)", for: .normal)
        dropOffButton.isEnabled = false
        cancelDropOffButton.isHidden = false
    }
    
    
    @IBAction func onPickUpPressed(_ sender: UIButton) {
        confirmPickUp()
    }
    @IBAction func onDropOffPressed(_ sender: UIButton) {
        confirmDropOff()
    }
    @IBAction func onCancelPickUpPressed(_ sender: UIButton) {
    }
    @IBAction func onCancelDropOffPressed(_ sender: UIButton) {
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
    
    func cancelPickUp() {
        
        let message = "Do you want to cancel picking up \(childNames)?" //from location
        // create the alert
        let alert = UIAlertController(title: "Carpooler", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add action buttons
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            API.unclaimPickUp(trip: self.trip, completion: { (error) in
                
                //send notification to the parent trip.owner
                self.resetPickup()
            })
            
            API.claimPickUp(trip: self.trip, completion: { (error) in
                self.disablePickup()
            })
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func cancelDropOff() {
        
        let message = "Do you want to cancel dropping off \(childNames)?" //from location
        // create the alert
        let alert = UIAlertController(title: "Carpooler", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add action buttons
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            API.unclaimPickUp(trip: self.trip, completion: { (error) in
                
                //send notification to the parent trip.owner
                self.resetDropoff()
            })
            
            API.claimPickUp(trip: self.trip, completion: { (error) in
                self.disablePickup()
            })
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

