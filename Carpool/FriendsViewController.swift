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

class FriendsViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var friendsSearchBar: UISearchBar!
    
    var friends: [CarpoolKit.User] = []
    
    override func viewDidLoad() {
        
        API.observeFriends(sender: self) { result in
            switch result {
            // called whenever app-user’s friends change
            case .success(let friends):
                self.friends = friends
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return users.count
        } else {
            return friends.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultsCell", for: indexPath)
            cell.textLabel?.text = users[indexPath.row].name
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExistingFriendsCell", for: indexPath)
            cell.textLabel?.text = friends[indexPath.row].name
            return cell
        default:
            self.displayErrorMessage(title: "No Friends are showing", message: "Please check your cellular connection")
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExistingFriends", for: indexPath)
            return cell
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        API.add(friend: user)
        
        // give app-user feedback that friend was added
    }
    
    var users: [CarpoolKit.User] = []
    
    
//    func confirmPickUp() {
//        
//        let message = "Do you want to pickup \(childNames)?" //from location
//        // create the alert
//        let alert = UIAlertController(title: "Carpooler", message: message, preferredStyle: UIAlertControllerStyle.alert)
//        
//        // add action buttons
//        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
//            API.claimPickUp(trip: self.trip, completion: { (error) in
//                self.disablePickup()
//                self.cancelPickUpButton.isHidden = false
//            })
//        }))
//        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
//        
//        // show the alert
//        self.present(alert, animated: true, completion: nil)
//        
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
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchBarText = searchBar.text {
            tableView.reloadData()
            title = "Loading…"
            refreshControl?.beginRefreshing()
            // need additional line of code
            //searchForFriends(forUsersWithName: searchBarText)
            API.search(forUsersWithName: searchBarText, completion: { (users) in
                switch users {
                case .success(let users):
                    self.users = users
                    self.tableView.reloadData()
                case .failure(_):
                    self.displayErrorMessage(title: "No Friends are showing", message: "Please check your cellular connection")
                }
            })
            
        }
        searchBar.resignFirstResponder()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
}



