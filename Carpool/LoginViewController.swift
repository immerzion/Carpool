//
//  LoginViewController.swift
//  Carpool
//
//  Created by Jess Telmanik on 11/9/17.
//  Copyright © 2017 Immerzion Interactive. All rights reserved.
//

import UIKit
import FirebaseCommunity
import CarpoolKit

let loginDidComplete = Notification.Name("LoginDidComplete")

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logSignSegment: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
    }
    
    
    
    
//    func signIn() {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        //API.signIn(email: emailTextField, password: passwordTextField) { (result) in
//            func validateTextFields() {
//                //activityIndicator.isHidden = false
//
//                var validEmail = false
//                var validPassword1 = false
//                var validPassword2 = false
//
//                if emailTextField.text == "" {
//                    validEmail = false
//                    displayErrorMessage("Username cannot be blank.")
//                }
//                else {
//                    validEmail = true
//                }
//
//                if passwordTextField.text == "" {
//                    validPassword1 = false
//                    displayErrorMessage("Password cannot be blank.")
//                }
//                else {
//                    validPassword1 = true
//                }
//
//                if confirmPassTextField.text == "" {
//                    validPassword2 = false
//                }
//                else {
//                    validPassword2 = true
//                }
//
//                if logSignSegment.selectedSegmentIndex == 0, validEmail, validPassword1 {
//                    signIn()
//                }
//
//                if logSignSegment.selectedSegmentIndex == 1, validEmail, validPassword1, validPassword2 {
//                    if passwordTextField.text == confirmPassTextField.text {
//                        createUser()
//                    }
//                    else {
//                        displayErrorMessage("Passwords do not match.")
//                    }
//                }
//
//
//            print("jess needs to get better at coding")
//        }
//    }
//
    func createUser() {
        
    }
        
    func displayErrorMessage(_ message: String) {
        let errorMessage = message
        // create the alert
        let alert = UIAlertController(title: "Carpool", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        //activityIndicator.isHidden = true
    }
    


    
    @IBAction func onSignLogTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex == 0 {
        case true:
            confirmPassTextField.isHidden = true
            fullNameTextField.isHidden = true
        case false:
            confirmPassTextField.isHidden = false
            fullNameTextField.isHidden = false
        }
    }
    
    
}

