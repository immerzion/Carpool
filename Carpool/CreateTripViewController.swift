//
//  CreateTripViewController.swift
//  Carpool
//
//  Created by Jess Telmanik on 11/7/17.
//  Copyright © 2017 Immerzion Interactive. All rights reserved.
//

import UIKit
import CarpoolKit
import MapKit


class CreateTripViewController: UIViewController {
    
    @IBOutlet weak var onPodSegPressed: UISegmentedControl!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var dateSelected: UIDatePicker!
    @IBOutlet weak var pickUpTimeDisplay: UILabel!
    @IBOutlet weak var dropOffTimeDisplay: UILabel!
    @IBOutlet weak var eventDescriptLabel: UILabel!
    
    //var clock: Timer?
    
    var pickUpTime = Date()
    var dropOffTime = Date()
    var currentTime = Date()
    
    var pickUpMsg = ""
    var dropOffMsg = ""
    
    var clLocation: MKPlacemark? = nil
    
    let savannah = CLLocation(latitude: 32.076176, longitude: -81.088371)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // clock = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: onTimerFired)
    }
    
    //fires on clock tick
    //    func onTimerFired(timer:Timer) {
    //        nameTextField.text = Date().prettyTime
    //    }
    
    override func viewDidAppear(_ animated: Bool) {
        dateSelected.minimumDate = Date()
        dateSelected.setDate(currentTime, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DestinationViewController
        if let locationText = locationTextField.text {
            destinationVC.searchText = locationText
        }
    }
    
    @IBAction func unwindFromDestinationVCWithSeque(seque: UIStoryboardSegue) {
        let destinationVC = seque.source as! DestinationViewController
        clLocation = destinationVC.selectedPin
        //print(clLocation)
        locationTextField.text = clLocation?.name
    }
    
    @IBAction func onPickUpDropOffSeg(_ sender: UISegmentedControl) {
        //        switch sender.selectedSegmentIndex == 0 {
        //        case true:
        //        case false:
        //        }
    }
    
    @IBAction func timeSelected(_ sender: UIDatePicker) {
        switch onPodSegPressed.selectedSegmentIndex {
        case 0:
            pickUpTime = self.dateSelected.date
            pickUpTimeDisplay.text = pickUpTime.prettyDate + " " + pickUpTime.prettyTime
        case 1:
            dropOffTime = self.dateSelected.date
            dropOffTimeDisplay.text = dropOffTime.prettyDate + " " + dropOffTime.prettyTime
        default:
            print(self.dateSelected.date)
        }
        generateEventDescription()
    }
    
    @IBAction func submitCarpoolButton(_ sender: UIButton) {
        validateText()
    }
    
    // extension of trip on view controller
    // add if let error handling if fields are nil
    func generateEventDescription() {
        let name = nameTextField.text!
        let location = locationTextField.text!
        
        switch onPodSegPressed.selectedSegmentIndex {
        case 0:
            pickUpMsg = "On \(pickUpTime.prettyDay), \(name) needs to be picked up for \(tripDescript(text: descriptionTextField.text!)) from \(location) at \(pickUpTime.prettyTime)"
            
        case 1:
            dropOffMsg = "On \(pickUpTime.prettyDay), \(name) needs to be dropped off at \(location) at \(pickUpTime.prettyTime)"
            
        default:
            print("msg")
        }
        
        eventDescriptLabel.text = """
        \(pickUpMsg)
        
        \(dropOffMsg)
        """
    }
    
    
    func tripDescript(text: String) -> String {
        if text == "" {
            return  "Annonymous Event"
        }
        return text
    }
    func createTripWithKids(desc: String, time: Date, loc: CLLocation?) {
        API.createTrip(eventDescription: desc, eventTime: time, eventLocation: loc) { result in
            switch result {
            case .success(let trip):
                
                print(trip)
                
                //                        if let child = self.child {
                //                            do {
                //                                try API.add(child: child, to: trip)
                //                                self.performSegue(withIdentifier: "unwindCreateTrip", sender: self)
                //                            } catch {
                //                                print("Create Trip Failed.")
                //                            }
            //                        }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func validateText() {
        
        //need to geocode location and add it here
        //need to have a list of [Child] and add it here
        var loc =  ""
        var name = ""
        var desc = ""
        
        if nameTextField.text == "" {
            nameTextField.textColor = red
        } else {
            name = nameTextField.text!
        }
        
        if descriptionTextField.text == "" {
            descriptionTextField.textColor = red
        } else {
            desc = descriptionTextField.text!
        }
        
        if locationTextField.text == "" {
            locationTextField.textColor = red
        } else {
            loc = locationTextField.text!
        }
        
        if desc == "" {
            print("you need to enter more data")
        } else {
            
            if pickUpTimeDisplay.text != "" {
                createTripWithKids(desc: desc, time: pickUpTime, loc: savannah)
            }
            
            if dropOffTimeDisplay.text != "" {
                createTripWithKids(desc: desc, time: dropOffTime, loc: savannah)
            }
            
        }
        
        
    }
}





