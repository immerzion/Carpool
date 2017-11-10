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

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var loginSignOut: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0, indexPath.row == 0 {
            print("bacon is delicious")
        }
        if indexPath.section == 1, indexPath.row == 0 {
            let vc = storyboard!.instantiateViewController(withIdentifier: "LoginViewController")
            present(vc, animated: true)
        }
    }
    
}
