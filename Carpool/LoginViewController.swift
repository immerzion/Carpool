//
//  LoginViewController.swift
//  Carpool
//
//  Created by Jess Telmanik on 11/9/17.
//  Copyright © 2017 Immerzion Interactive. All rights reserved.
//

import UIKit
import FirebaseCommunity

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
    }
    @IBAction func onSignLogTapped(_ sender: UISegmentedControl) {
    }
    
    //    @IBAction func onLoginPressed() {
//        UIApplication.shared.open(oauth!)
//        
//    }
//    
//    @IBAction func onSkipPressed() {
//        //TODO: Go to RootVC
//        dismiss(animated: true, completion: nil)
//    }
    
}
