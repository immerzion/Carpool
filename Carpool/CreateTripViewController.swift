//
//  CreateTripViewController.swift
//  Carpool
//
//  Created by Jess Telmanik on 11/7/17.
//  Copyright © 2017 Immerzion Interactive. All rights reserved.
//

import UIKit
import CarpoolKit
import CoreLocation


class CreateTripViewController: UIViewController {
    
    @IBOutlet weak var onPodSegPressed: UISegmentedControl!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var dateSelected: UIDatePicker!
    @IBOutlet weak var pickUpTimeDisplay: UILabel!
    @IBOutlet weak var dropOffTimeDisplay: UILabel!
    @IBOutlet weak var pickUpEventDescriptLabel: UILabel!
    
    var pickUpTime = Date()
    var dropOffTime = Date()
    var currentTime = Date()
    
    let savannah = CLLocation(latitude: 32.076176, longitude: -81.088371)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dateSelected.minimumDate = Date()
        dateSelected.setDate(currentTime, animated: true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let kidPopOverVC = segue.destination.popoverPresentationController as KidsPopOverViewController
//        
//    }
    
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
    }
    
    @IBAction func submitCarpoolButton(_ sender: UIButton) {
        validateText()
    }
    
    func generateEventDescription() -> String {
        switch onPodSegPressed.selectedSegmentIndex {
        case 0:
            let name = nameTextField.text!
            let location = locationTextField.text!
            let desc = "On \(pickUpTime.prettyDay), \(name) needs to be PICKED UP from \(location) at \(pickUpTime.prettyTime)"
            return desc
        case 1:
            let name = nameTextField.text!
            let location = locationTextField.text!
            let desc = "On \(pickUpTime.prettyDay), \(name) needs to be DROPPED OFF at \(location) at \(pickUpTime.prettyTime)"
            return desc

            
        default:
            print("something is working")
            return ""
        }
    } // add if let error handling if fields are nil
    
    
    func validateText() {
        let event = ""
        var location =  ""
        //var pickUpTime = ""
        //var dropOffTime = ""
        
        
        if locationTextField.text == "" {
            locationTextField.textColor = UIColor.red
        } else {
            location = locationTextField.text!
        }

        
        if location == "" || pickUpTimeDisplay.text == "" {
            print("you need to enter more data")
            
        } else {
            pickUpEventDescriptLabel.text = generateEventDescription()
            API.createTrip(eventDescription: event, eventTime: pickUpTime, eventLocation: savannah, completion: { (trip) in
                print(trip)
            })
        }
    }
    
}
