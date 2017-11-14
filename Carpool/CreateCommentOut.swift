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







//override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    switch indexPath.section {
//    case 0:
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResults", for: indexPath)
//        cell.textLabel?.text = users[indexPath.row].name
//        //            if cell.textLabel?.text != nil {
//        //            } else {
//        //                self.displayErrorMessage(title: "No Friends are showing", message: "Please check your cellular connection")
//        //            }
//        return cell
//    case 1:
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ExistingFriends", for: indexPath)
//        cell.textLabel?.text = friends[indexPath.row].name
//        //            if cell.textLabel?.text != nil {
//        //            } else {
//        //                self.displayErrorMessage(title: "No Friends are showing", message: "Please check your cellular connection")
//        //            }
//        return cell
//    default:
//        print("jess figure out what should be here...")
//        return users
//    }
//}

