//
//  FriendsViewController.swift
//  Carpool
//
//  Created by Jess Telmanik on 11/13/17.
//  Copyright © 2017 Immerzion Interactive. All rights reserved.
//

import UIKit
import CarpoolKit
import FirebaseCommunity

class FriendsViewController: UITableViewController {
    
    @IBOutlet weak var friendsSearchBar: UISearchBar!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResults", for: indexPath)
//        cell.textLabel?.text =
//    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return searchForFriends.count
//    }
    
    
    func searchForFriends(forUsersWithName: String) {
        API.search(forUsersWithName: forUsersWithName) { result in
            switch result {
            case .success(let users):
                print(users)
            case .failure(_):
                self.displayErrorMessage(title: "No Friends are showing", message: "Please check your cellular connection")
            }
        }
    }
    
    
//    func addFriend(friend: String) {
//        API.add(friend: friend)
//    }
    
    
    
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
