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
    
    var trips: [Trip] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.fetchTripsOnce { trips in
            self.trips = trips
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        cell.textLabel?.text = trips[indexPath.row].event.description
        
        if !trips[indexPath.row].pickUp.isClaimed {
            cell.backgroundColor = UIColor.red
        }
        
        if !trips[indexPath.row].dropOff.isClaimed {
            cell.backgroundColor = UIColor.red
        }
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let eventDetailVC = segue.destination as! EventDetailViewController
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        eventDetailVC.trip = trips[indexPath.row]
    }
}

