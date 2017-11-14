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


// use cancel button to hide search results once a friend is selected


class FriendsViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var friendsSearchBar: UISearchBar!
    
    var friends: [CarpoolKit.User] = []
    var users: [CarpoolKit.User] = []
    var searchTitle = ""
    
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return searchTitle
        } else {
            return "My Friends"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultsCell", for: indexPath)
            cell.textLabel?.text = users[indexPath.row].name
            // add icon for select/unselect icon here
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExistingFriendsCell", for: indexPath)
            cell.textLabel?.text = friends[indexPath.row].name
            // add icon for select/unselect icon here
            return cell
        default:
            self.displayErrorMessage(title: "No Friends are showing", message: "Please check your cellular connection")
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExistingFriends", for: indexPath)
            return cell
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let user = users[indexPath.row]
            confirmAddFriend(friend: user)
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
        case 1:
            let user = friends[indexPath.row]
            deleteFriend(friend: user)
        default:
            print("error")
        }
        

    }
    
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
////
////        let user = friends[indexPath.row]
////        deleteFriend(friend: friends)
//
//        friends.remove(at: indexPath.row)
//        tableView.deleteRows(at: [indexPath], with: .automatic)
//
//    }
//
    
    func deleteFriend(friend: CarpoolKit.User) {
        let popName = friend.name!
        let message = "Do you want to delete \(popName) from your friends list?"
        let alert = UIAlertController(title: "Carpooler", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (alert) in
            API.remove(friend: friend)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func confirmAddFriend(friend: CarpoolKit.User) {
        let popUpName = friend.name!
        let message = "Do you want to add \(popUpName) to your friends list?"
        let alert = UIAlertController(title: "Carpooler", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (alert) in
            API.add(friend: friend)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func displayErrorMessage(title: String, message: String) {
        let errorMessage = message
        let alert = UIAlertController(title: title, message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchBarText = searchBar.text {
            tableView.reloadData()
            refreshControl?.beginRefreshing()
            API.search(forUsersWithName: searchBarText, completion: { (users) in
                switch users {
                case .success(let users):
                    self.users = users
                    self.searchTitle = "Search Results"
                    // when clear cancel button is active change search results to blank
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



