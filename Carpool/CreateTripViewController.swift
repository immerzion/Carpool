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
    
    @IBOutlet weak var podSegmentControl: UISegmentedControl!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var dateSelected: UIDatePicker!
    @IBOutlet weak var eventDescriptLabel: UILabel!
    @IBOutlet weak var reoccuringSwitch: UISwitch!
    @IBOutlet weak var dropOffSwitch: UISwitch!
    @IBOutlet weak var pickUpSwitch: UISwitch!
    
    var startTime = Date()
    var endTime = Date()
    var currentTime = Date()
    
    var pickUpMsg = ""
    var dropOffMsg = ""
    let startMsg = "Start Time"
    let endMsg = "End Time"
    
    var kidsArray: [Child] = []
    
    var clLocation: MKPlacemark? = nil
    let savannah = CLLocation(latitude: 32.076176, longitude: -81.088371)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        podSegmentControl.setTitle(startMsg, forSegmentAt: 0)
        podSegmentControl.setTitle(endMsg, forSegmentAt: 1)
        
        dateSelected.setValue(UIColor.white, forKey: "textColor")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        dateSelected.minimumDate = Date()
        dateSelected.setDate(currentTime, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DestinationVC" {
            
            let destinationVC = segue.destination as! DestinationViewController
            if let locationText = locationTextField.text {
                destinationVC.searchText = locationText
            }
            if segue.identifier == "KidsTable" {
                //let KidsTableVC = segue.destination as! KidsTableViewController
            }
        }
    }
    
    @IBAction func unwindFromDestinationVCWithSeque(seque: UIStoryboardSegue) {
        let destinationVC = seque.source as! DestinationViewController
        clLocation = destinationVC.selectedPin
        //print(clLocation)
        locationTextField.text = clLocation?.name
    }
    
    @IBAction func unwindFromKidsTableVC(seque: UIStoryboardSegue) {
        let kidsTableVC = seque.source as! KidsTableViewController
        kidsArray = kidsTableVC.selectedKidsArray
        var kidsNames = ""
        for kid in kidsArray {
            kidsNames += "\(kid.name) "
        }
        nameTextField.text = kidsNames
    }
    
    func dismissVC() {
        performSegue(withIdentifier: "RootVC", sender: nil)
    }
    
    @IBAction func onPickUpDropOffSeg(_ sender: UISegmentedControl) {
        //        switch sender.selectedSegmentIndex == 0 {
        //        case true:
        //        case false:
        //        }
    }
    
    @IBAction func timeSelected(_ sender: UIDatePicker) {
        switch podSegmentControl.selectedSegmentIndex {
        case 0:
            startTime = self.dateSelected.date
            let startText = startTime.prettyDate + " " + startTime.prettyTime
            podSegmentControl.setTitle(startText, forSegmentAt: 0)
            
        case 1:
            endTime = self.dateSelected.date
            let endText = endTime.prettyDate + " " + endTime.prettyTime
            podSegmentControl.setTitle(endText, forSegmentAt: 1)
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
        
        switch podSegmentControl.selectedSegmentIndex {
        case 0:
            dropOffMsg = "\(startTime.prettyDay) - \(startTime.prettyTime) - Drop off \(name) to \(location)."
        //tripDescript(text: descriptionTextField.text!
        case 1:
            pickUpMsg = "\(endTime.prettyDay) - \(endTime.prettyTime) - Pick up \(name) from \(location)."
        default:
            print("msg")
        }
        
        eventDescriptLabel.text = """
        \(dropOffMsg)
        
        \(pickUpMsg)
        """
    }
    
    
    func tripDescript(text: String) -> String {
        if text == "" {
            return  "Unnamed Event"
        }
        return text
    }
    
    func createTripWithKids(desc: String, time: Date, loc: CLLocation?) {
        API.createTrip(eventDescription: desc, eventTime: time, eventLocation: loc) { result in
            switch result {
            case .success(let trip):
                
                //set end time for event
                //the other option is to create a separate event, currently commented out
                if self.podSegmentControl.titleForSegment(at: 1) != self.endMsg {
                    API.set(endTime: self.endTime, for: trip.event, completion: { (error) in
                        print("Error adding end time to event")
                    })
                }
                
                //set reocurring event
                if self.reoccuringSwitch.isOn {
                    API.mark(trip: trip, repeating: true)
                }
                
                //add kids to the trip
                if self.kidsArray.count > 0 {
                    for kid in self.kidsArray {
                        do {
                            try API.add(child: kid, to: trip)
                        } catch {
                            print("Error adding child to trip")
                        }
                    }
                }
        
                //pick up a leg of a trip while scheduling
                if self.pickUpSwitch.isOn {
                    API.claimPickUp(trip: trip, completion: { (error) in
                        print("Error claiming pick up leg of this trip.")
                    })
                } else {
                    API.unclaimPickUp(trip: trip, completion: { (error) in
                        print("Error unclaiming pick up leg of this trip.")
                    })
                }
                
                if self.dropOffSwitch.isOn {
                    API.claimDropOff(trip: trip, completion: { (error) in
                        print("Error claiming drop off leg of this trip.")
                    })
                } else {
                    API.unclaimDropOff(trip: trip, completion: { (error) in
                        print("Error unclaiming drop off leg of this trip.")
                    })
                }
                
                
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
            print("You need to enter more data")
        }
        else {
            
            if podSegmentControl.titleForSegment(at: 0) != startMsg {
                createTripWithKids(desc: desc, time: startTime, loc: savannah)
            }
            
            //this creates a separate event, now we are setting end time for original event
            //            if podSegmentControl.titleForSegment(at: 1) != endMsg  {
            //                createTripWithKids(desc: desc, time: pickUpTime, loc: savannah)
            //            }
            
            dismissVC()
        }
    }
    
    
}





