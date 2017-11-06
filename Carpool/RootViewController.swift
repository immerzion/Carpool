//
//  RootViewController.swift
//  Carpool
//
//  Created by Ernesto Bautista on 11/6/17.
//  Copyright © 2017 Immerzion Interactive. All rights reserved.
//

import CoreLocation
import CarpoolKit
import UIKit

class RootViewController: UITableViewController {
    
    let testArray = ["zero", "one", "two", "three", "four", "five"]
    var sendToEventDetailVC = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //API.fetchTripsOnce { (<#[Trip]#>) in
        //    <#code#>
        //}
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        cell.textLabel?.text = testArray[indexPath.row]
        sendToEventDetailVC = testArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //<#code#>
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let eventDetailVC = segue.destination as! EventDetailViewController
        eventDetailVC.idLabel.text = sendToEventDetailVC
    }


}

