//
//  KidsTableViewController.swift
//  Carpool
//
//  Created by Ernesto Bautista on 11/15/17.
//  Copyright © 2017 Immerzion Interactive. All rights reserved.
//

import Foundation
import UIKit
import CarpoolKit


class KidsTableViewController: UITableViewController {

    var kidsArray: [Child] = []
    var selectedKidsArray: [Child] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getMyKids()
    }

    override func viewDidAppear(_ animated: Bool) {
        //tableView.reloadData()
    }
    
    func getMyKids() {
        API.fetchCurrentUser { (result) in
            switch result {
                
            case .success(let user):
                
                self.kidsArray.removeAll()
                if user.children.count > 0 {
                    self.kidsArray = user.children
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func test() {
        var array = ["one", "two", "three"]
        array.removeObject("two")
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let selectedKid = kidsArray[indexPath.row]
            
            var index = 0
            for kid in selectedKidsArray {
                if kid.name == selectedKid.name {
                    selectedKidsArray.remove(at: index)
                    cell?.accessoryType = .none
                }
                index += 1
            }
        
            selectedKidsArray.append(kidsArray[indexPath.row])
            cell?.accessoryType = .checkmark
        }
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kidsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KidCell", for: indexPath)
        cell.textLabel?.text = kidsArray[indexPath.row].name
        return cell
    }

}

