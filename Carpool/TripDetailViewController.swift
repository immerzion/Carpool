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
    @IBOutlet weak var deleteButton: UIButton!
    
    
    var trip: Trip!
    var me: User!
    var podLeg: Leg!
    var childNames = ""
    var location = CLLocation()
    
    let savannah = CLLocation(latitude: 32.076176, longitude: -81.088371)
    

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
        
//        API.fetchCurrentUser { (result) in
//            switch result {
//            case .success(let user):
//                self.me = user
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        resetButtons()
        
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
            childNames += child.name + " "
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
        
        if let pickUp = trip.pickUp, pickUp.driver.isMe {
            pickUpButton.setTitle("You will pickup " + childNames, for: .normal)
            cancelPickUpButton.isHidden = false
        }
        else if let name = trip.pickUp?.driver.name {
            pickUpButton.setTitle(name + " will pickup " + childNames, for: .normal)
            cancelPickUpButton.isHidden = true
        } else {
            pickUpButton.setTitle("Pick up has been scheduled", for: .normal)
            
        }
        
        pickUpButton.isEnabled = false
    }
    
    func disableDropoff() {
        
        if let dropOff = trip.dropOff, dropOff.driver.isMe {
           dropOffButton.setTitle("You will drop off " + childNames, for: .normal)
            cancelDropOffButton.isHidden = false
        }
        else if let name = trip.dropOff?.driver.name {
            dropOffButton.setTitle(name + " will drop off " + childNames, for: .normal)
            cancelDropOffButton.isHidden = true
        } else {
            dropOffButton.setTitle("Drop off has been scheduled", for: .normal)
        }
        
        dropOffButton.isEnabled = false
    }
    
    
    @IBAction func onPickUpPressed(_ sender: UIButton) {
        confirmPickUp()
    }
    @IBAction func onDropOffPressed(_ sender: UIButton) {
        confirmDropOff()
    }
    @IBAction func onCancelPickUpPressed(_ sender: UIButton) {
        cancelPickUp()
    }
    @IBAction func onCancelDropOffPressed(_ sender: UIButton) {
        cancelDropOff()
    }
    @IBAction func onDeletePressed(_ sender: UIButton) {
    }
    
    
    
    func confirmPickUp() {
        
        let message = "Do you want to pickup \(childNames)?" //from location
        // create the alert
        let alert = UIAlertController(title: "Carpooler", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add action buttons
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (alert) in
            API.claimPickUp(trip: self.trip, completion: { (error) in
                self.disablePickup()
                self.cancelPickUpButton.isHidden = false
            })
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    
    }
    
    
    //remove alerts to confirm pick up and drop offs - user should not have to confirm twice per max and the user experience
    
    func confirmDropOff() {
        
        let message = "Do you want to drop off \(childNames)?" //at location
        // create the alert
        let alert = UIAlertController(title: "Carpooler", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add action buttons
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (alert) in
            API.claimDropOff(trip: self.trip, completion: { (error) in
                self.disableDropoff()
                self.cancelDropOffButton.isHidden = false
            })
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func cancelPickUp() {
        
//        let message = "Do you want to cancel picking up \(childNames)?" //from location
//        // create the alert
//        let alert = UIAlertController(title: "Carpooler", message: message, preferredStyle: UIAlertControllerStyle.alert)
//
//        // add action buttons
//        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (alert) in
            API.unclaimPickUp(trip: self.trip, completion: { (error) in
                
                //send notification to the parent trip.owner
                self.resetPickup()
            })
        }
//    ))
//        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
//        
//        // show the alert
//        self.present(alert, animated: true, completion: nil)
//        
//    }
    
    func cancelDropOff() {
        
        let message = "Do you want to cancel dropping off \(childNames)?" //from location
        // create the alert
        let alert = UIAlertController(title: "Carpooler", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add action buttons
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            API.unclaimDropOff(trip: self.trip, completion: { (error) in
                
                //send notification to the parent trip.owner
                self.resetDropoff()
            })
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

