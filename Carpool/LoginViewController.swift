//
//  LoginViewController.swift
//  Carpool
//
//  Created by Jess Telmanik on 11/9/17.
//  Copyright © 2017 Immerzion Interactive. All rights reserved.
//

import UIKit
import FirebaseCommunity

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
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if emailTextField.text != nil, passwordTextField.text != nil {
        
            if logSignSegment.selectedSegmentIndex == 0 {
                Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                    if let error = error {
                        print(#function, error)
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false //check placement
                    }
                })
            } else {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                    if let error = error {
                        //TODO show alert
                        print(#function, error)
                    } else {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false //check placement
                    }
                })
            }
        }
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
