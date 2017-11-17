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
    
    @IBOutlet weak var kidsCell: UITableViewCell!
    @IBOutlet weak var myKidsLabel: UILabel!
    
    @IBOutlet weak var scheduleCell: UITableViewCell!
    @IBOutlet weak var myTripsLabel: UILabel!
    
    @IBOutlet weak var friendsCell: UITableViewCell!
    @IBOutlet weak var myFriendsLabel: UILabel!
    
    @IBOutlet weak var logOutCell: UITableViewCell!
    @IBOutlet weak var logOutLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    
    var name = ""
    var kidsArray: [Child] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadUserData()
    }
    
    func loadUserData() {
        API.fetchCurrentUser { (result) in
            switch result {
                
            case .success(let user):
                self.name = user.name!
                
                if user.children.count > 0 {
                    self.kidsArray = user.children
                    
                    var kidNames = ""
                    for kid in self.kidsArray {
                        kidNames += kid.name + " "
                    }
                    
                    self.myKidsLabel.text = "\(self.kidsArray.count) kids: \(kidNames)"
                } else {
                    self.myKidsLabel.text = "My Kids"
                }
                
                self.nameLabel.text = user.name
                self.phoneNumberLabel.text = user.phoneNumber
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    @IBAction func unwindFromLoginVC(segue: UIStoryboardSegue) {
        let loginVC = segue.source as? LoginViewController
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0, indexPath.row == 0 {
            // put profile information here... photo and username... possibly children too
        }
        if indexPath.section == 5, indexPath.row == 0 {
            let vc = storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
            present(vc, animated: true)
        }
    }

}

//    //temporary add kids in code
//    //confirmAddKids()
//
//
//    func loadAllKids() {
//        let kidsNames = ["Curly", "Larry", "Moe", "Shemp", "Sue"]
//        for kid in kidsNames {
//            API.addChild(name: kid, completion: { (result) in
//                switch result {
//                case .success(let kid):
//                    print(kid)
//                case .failure(let error):
//                    print(error)
//                }
//            })
//        }
//    }
//
//    //no longer needed
//    func confirmAddKids() {
//
//        let message = "Do you want to add some random kids to your profile?"
//        // create the alert
//        let alert = UIAlertController(title: "Carpooler", message: message, preferredStyle: UIAlertControllerStyle.alert)
//
//        // add action buttons
//        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (alert) in
//            self.loadAllKids()
//        }))
//        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: nil))
//
//        // show the alert
//        self.present(alert, animated: true, completion: nil)
//
//    }


