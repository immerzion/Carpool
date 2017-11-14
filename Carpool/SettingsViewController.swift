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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0, indexPath.row == 0 {
            // put profile information here... photo and username... possibly children too
        }
        if indexPath.section == 1, indexPath.row == 0 {
            // put additional settings in newVC from here
//            let vc = storyboard!.instantiateViewController(withIdentifier: "some random thing not created yet")
//            present(vc, animated: true)
        }
        if indexPath.section == 2, indexPath.row == 0 {
            let vc = storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
            present(vc, animated: true)
        }
    }
    
}
