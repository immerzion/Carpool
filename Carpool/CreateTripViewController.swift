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
    @IBOutlet weak var eventDescriptionTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var dateSelected: UIDatePicker!
    @IBOutlet weak var pickUpTimeDisplay: UILabel!
    @IBOutlet weak var dropOffTimeDisplay: UILabel!
    
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
    
    
    func validateText() {
        var event = ""
        var location =  ""
        //var pickUpTime = ""
        //var dropOffTime = ""
        
        if eventDescriptionTextField.text == "" {
            eventDescriptionTextField.textColor = UIColor.red
        } else {
            event = eventDescriptionTextField.text!
        }
        
        if locationTextField.text == "" {
            locationTextField.textColor = UIColor.red
        } else {
            location = locationTextField.text!
        }
        
//        if pickUpTimeDisplay.text == "" {
//            pickUpTimeDisplay.textColor = UIColor.red
//        } else {
//            pickUpTime = pickUpTimeDisplay.text!
//        }
//
//        if dropOffTimeDisplay.text == "" {
//            dropOffTimeDisplay.textColor = UIColor.red
//        } else {
//            dropOffTime = dropOffTimeDisplay.text!
//        }
        
        if event == "" || location == "" || pickUpTimeDisplay.text == "" {
            print("you need to enter more data")
        } else {
            API.createTrip(eventDescription: event, eventTime: pickUpTime, eventLocation: savannah, completion: { (trip) in
                print(trip)
            })
        }
    }
    
}
