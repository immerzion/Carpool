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
    
    @IBOutlet weak var tableRefresh: UIRefreshControl!
    
    
    var trips: [Trip] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        API.observeTrips { (result) in
            switch result {
            case .success(let trips):
                self.trips = trips
                self.tableView.reloadData()
            case .failure(let error):
                //TODO
                print(#function, error)
            }
        }
        
    }
    
//VC needs title.
//Realtime clock would be nice
//Hide and possibly show fully scheduled trips
    
    @IBAction func onRefreshPulled(_ sender: UIRefreshControl) {
        tableView.reloadData()
        tableRefresh.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        cell.textLabel?.text = trips[indexPath.row].event.description
        
        if !(trips[indexPath.row].pickUp != nil) {
            cell.backgroundColor = UIColor.red
        }
        
        if !(trips[indexPath.row].dropOff != nil)  {
            cell.backgroundColor = UIColor.red
        }
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TripDetail" {
        let tripDetailVC = segue.destination as! TripDetailViewController
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        tripDetailVC.trip = trips[indexPath.row]
        }
        if segue.identifier == "CreateTrip" {
            let createTripVC = segue.destination as! CreateTripViewController
            print(createTripVC)
            //guard let indexPath = tableView.indexPathForSelectedRow else { return }
            //createTripVC.trip = trips[indexPath.row]
        }
    }
}

