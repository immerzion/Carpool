////
////  CreateCommentOut.swift
////  Carpool
////
////  Created by Jess Telmanik on 11/8/17.
////  Copyright © 2017 Immerzion Interactive. All rights reserved.
////
//
//import Foundation
//
//func validateText() {
//    let event = ""
//    var location =  ""
//    //var pickUpTime = ""
//    //var dropOffTime = ""
//    
//    //        if eventDescriptionTextField.text == "" {
//    //            eventDescriptionTextField.textColor = UIColor.red
//    //        } else {
//    //            event = eventDescriptionTextField.text!
//    //        }
//    
//    if locationTextField.text == "" {
//        locationTextField.textColor = UIColor.red
//    } else {
//        location = locationTextField.text!
//    }
//    
//    //        if pickUpTimeDisplay.text == "" {
//    //            pickUpTimeDisplay.textColor = UIColor.red
//    //        } else {
//    //            pickUpTime = pickUpTimeDisplay.text!
//    //        }
//    //
//    //        if dropOffTimeDisplay.text == "" {
//    //            dropOffTimeDisplay.textColor = UIColor.red
//    //        } else {
//    //            dropOffTime = dropOffTimeDisplay.text!
//    //        }
//    
//    if location == "" || pickUpTimeDisplay.text == "" {
//        print("you need to enter more data")
//        
//    } else {
//        pickUpEventDescriptLabel.text = generateEventDescription()
//        API.createTrip(eventDescription: event, eventTime: pickUpTime, eventLocation: savannah, completion: { (trip) in
//            print(trip)
//        })
//    }
//}
//
//}



//        if emailTextField.text != nil, passwordTextField.text != nil {
//
//            if logSignSegment.selectedSegmentIndex == 0 {
//                Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
//                    if let error = error {
//                        print(#function, error)
//                    } else {
//                        UIApplication.shared.isNetworkActivityIndicatorVisible = false //check placement
//                    }
//                })
//            } else {
//                UIApplication.shared.isNetworkActivityIndicatorVisible = true
//
//                    if let error = error {
//                        //TODO show alert
//                        print(#function, error)
//                    } else {
//                        UIApplication.shared.isNetworkActivityIndicatorVisible = false //check placement
//                    }
//                })
//            }
//        }
//    }
//


// Display error message code

//func displayErrorMessage(title: String, message: String) {
//    let errorMessage = message
//    // create the alert
//    let alert = UIAlertController(title: title, message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
//    // add an action (button)
//    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//    // show the alert
//    self.present(alert, animated: true, completion: nil)
//    //activityIndicator.isHidden = true
//}

