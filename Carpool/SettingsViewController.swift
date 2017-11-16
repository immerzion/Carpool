//
//  SettingsViewController.swift
//  Carpool
//
//  Created by Jess Telmanik on 11/9/17.
//  Copyright © 2017 Immerzion Interactive. All rights reserved.
//

import UIKit
import FirebaseCommunity
import CarpoolKit

// add 3rd section -> move to top and add profile cell with photo and username shown

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var loginSignOut: UITableViewCell!
    
    var name = ""
    var kidsArray: [Child] = []
    
    let kidsNames = ["Curly", "Larry", "Moe", "Shemp", "Sue"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.fetchCurrentUser { (result) in
            switch result {
                
            case .success(let user):
                self.name = user.name!
                
                if user.children.count > 0 {
                    self.kidsArray = user.children
                }
            case .failure(let error):
                print(error)
            }
        }
        
        //temporary add kids in code
        confirmAddKids()
    }
    
    func loadAllKids() {
        for kid in kidsNames {
            API.addChild(name: kid, completion: { (result) in
                switch result {
                    
                case .success(let kid):
                    print(kid)
                case .failure(let error):
                    print(error)
                }
            })
    }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0, indexPath.row == 0 {
            // put profile information here... photo and username... possibly children too
        }
        if indexPath.section == 1, indexPath.row == 0 {
            let vc = storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
            present(vc, animated: true)
        }
    }
    
    func confirmAddKids() {
        
        let message = "Do you want to add some random kids to your profile?"
        // create the alert
        let alert = UIAlertController(title: "Carpooler", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add action buttons
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (alert) in
            self.loadAllKids()
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func unwindFromLoginVC(segue: UIStoryboardSegue) {
        let loginVC = segue.source as? LoginViewController
    }
    
}
