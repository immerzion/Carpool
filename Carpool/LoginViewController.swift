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


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var logSignSegment: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    //need outloet for loginbutton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.logSignSegment.layer.cornerRadius = 5
        initializeLogin()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y - 200, width:self.view.frame.size.width, height:self.view.frame.size.height)
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame = CGRect(x:self.view.frame.origin.x, y:self.view.frame.origin.y + 200, width:self.view.frame.size.width, height:self.view.frame.size.height)
        }
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
    
    @IBAction func onCancelPressed(_ sender: UIButton) {
        dismissLoginVC()
    }
    
    func dismissLoginVC() {
        //need segue code here.  its gone for some reason
        dismiss(animated: true) {
            print("You are dismissed.")
        }
        
    }
    
    func initializeLogin() {
        fullNameTextField.alpha = 0
        phoneNumberTextField.alpha = 0
        confirmPassTextField.alpha = 0
        self.title = "Login to Carpool"
    }
    
    func initializeSignup() {
        fullNameTextField.alpha = 1
        phoneNumberTextField.alpha = 1
        confirmPassTextField.alpha = 1
        self.title = "Create Carpool Account"
    }
    
    func signIn(email: String, password: String) {
        API.signIn(email: email, password: password) { (user) in
            switch user {
            case .success:
                self.dismissLoginVC()
            case .failure(let error):
                self.displayErrorMessage(title: "Error Logging In", message: "Please check your internet connection and try again.")
                print(#function, error)
            }
        }
    }
    
    func signUp(email: String, password: String, fullName: String) {
        API.signUp(email: email, password: password, fullName: fullName) { result in
            switch result {
            case .success:
                if self.phoneNumberTextField.text != "" {
                    API.set(phoneNumber: self.phoneNumberTextField.text!)
                }
                self.dismissLoginVC()
            case .failure(let error):
                self.displayErrorMessage(title: "Sign Up Error", message: "Account does not exist.")
                print(#function, error)
            }
        }
    }
    
    func validateTextFields() {
        //activityIndicator.isHidden = false
        
        var validName = false
        var validEmail = false
        var validPassword1 = false
        var validPassword2 = false
        
        if fullNameTextField.text == "", logSignSegment.selectedSegmentIndex == 1 {
            validName = false
            displayErrorMessage(title: "Carpooler", message: "Name cannot be blank.")
        } else {
            validName = true
        }
        
        if emailTextField.text == "" {
            validEmail = false
            displayErrorMessage(title: "Carpooler", message: "Username cannot be blank.")
        } else {
            validEmail = true
        }
        
        if passwordTextField.text == "" {
            validPassword1 = false
            displayErrorMessage(title: "Carpooler", message: "Password cannot be blank.")
        } else {
            validPassword1 = true
        }
        
        if confirmPassTextField.text == "", logSignSegment.selectedSegmentIndex == 1 {
            validPassword2 = false
            displayErrorMessage(title: "Carpooler", message: "Confirm password and try again.")
        } else {
            validPassword2 = true
        }
        
        
        if logSignSegment.selectedSegmentIndex == 0, validEmail, validPassword1 {
            signIn(email: emailTextField.text!, password: passwordTextField.text!)
        }
        
        if logSignSegment.selectedSegmentIndex == 1, validName, validEmail, validPassword1, validPassword2 {
            if passwordTextField.text == confirmPassTextField.text {
                signUp(email: emailTextField.text!, password: passwordTextField.text!, fullName: fullNameTextField.text!)
            }
            else {
                displayErrorMessage(title: "Carpooler", message: "Passwords do not match.")
            }
        }
    }
    
    func displayErrorMessage(title: String, message: String) {
        let errorMessage = message
        // create the alert
        let alert = UIAlertController(title: title, message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        //activityIndicator.isHidden = true
    }
    
}
