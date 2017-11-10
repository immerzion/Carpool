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
        validateTextFields()
    }
    
    @IBAction func onSignLogTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            initializeLogin()
        case 1:
            initializeSignup()
        default:
            break
        }
    }
    
    func initializeLogin() {
        confirmPassTextField.isHidden = true
        fullNameTextField.isHidden = true
    }
    
    func initializeSignup() {
        confirmPassTextField.isHidden = false
        fullNameTextField.isHidden = false
    }
    
    func signIn(email: String, password: String) {
        API.signIn(email: email, password: password) { (user) in
            switch user {
            case .success(_):
                print(user, "sign in successful")
            case .failure(_):
                print(user, "error")
            }
        }
    }
    
    func signUp(email: String, password: String, fullName: String) {
        API.signUp(email: email, password: password, fullName: fullName) { (user) in
            switch user {
            case .success(_):
                print(user, "sign up successful")
            case .failure(_):
                print(user, "error")
            }
        }
    }
    
    func validateTextFields() {
        //activityIndicator.isHidden = false
        
        var validEmail = false
        var validPassword1 = false
        var validPassword2 = false
        
        if emailTextField.text == "" {
            validEmail = false
            displayErrorMessage("Username cannot be blank.")
        } else {
            validEmail = true
        }
        
        if passwordTextField.text == "" {
            validPassword1 = false
            displayErrorMessage("Password cannot be blank.")
        } else {
            validPassword1 = true
        }
        
        if confirmPassTextField.text == "" {
            validPassword2 = false
        } else {
            validPassword2 = true
        }
        
        if fullNameTextField.text == "" {
            validPassword1 = false
            displayErrorMessage("Name cannot be blank.")
        } else {
            validPassword1 = true
        }
        
        if logSignSegment.selectedSegmentIndex == 0, validEmail, validPassword1 {
            signIn(email: emailTextField.text!, password: passwordTextField.text!)
        }
        
        if logSignSegment.selectedSegmentIndex == 1, validEmail, validPassword1, validPassword2 {
            if passwordTextField.text == confirmPassTextField.text {
                signUp(email: emailTextField.text!, password: passwordTextField.text!, fullName: fullNameTextField.text!)
            }
            else {
                displayErrorMessage("Passwords do not match.")
            }
        }
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
    
}
