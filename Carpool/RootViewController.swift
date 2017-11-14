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
    @IBOutlet weak var eventListSegControl: UISegmentedControl!
    
    var trips: [Trip] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        tableView.estimatedRowHeight = 80
        
        filteredTrips()
        
    }
    
    //VC needs title.
    //Realtime clock would be nice
    //Hide and possibly show fully scheduled trips
    
    
    func allTrips() {
        
        trips.removeAll()
        
        API.observeTrips(sender: self, completion: { (result) in
            switch result {
            case .success(let trips):
                self.trips = trips
                self.tableView.reloadData()
            case .failure(let error):
                //TODO
                print(#function, error)
            }
        })
    }
    
    func filteredTrips() {
        
        trips.removeAll()
        //will need to add unobserve function when it is ready
        
        API.observeTrips(sender: self, completion: { (result) in
            switch result {
            case .success(let trips):
                
                for trip in trips {
                    //if trip is fully scheduled...
                    if trip.pickUp != nil, trip.dropOff != nil {
                        print("trip fully scheduled")
                    } else {
                        self.trips.append(trip)
                        self.tableView.reloadData()
                    }
                }
                
                self.tableView.reloadData()
            case .failure(let error):
                //TODO
                print(#function, error)
            }
        })
    }
    
    @IBAction func onFilterPressed(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            filteredTrips()
        case 1:
            allTrips()
        default:
            break
        }
    }
    
    @IBAction func onRefreshPulled(_ sender: UIRefreshControl) {
        
        // add feature so that update pickup etc is shown when returning to rootVC
        // make seg control friends/user list isHidden when refreshing
        
        tableView.reloadData()
        tableRefresh.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    //        trip.pickUp?.driver
    //        trip.dropOff?.driver
    //
    //        trip.event.owner.name
    //        trip.event.owner.isMe
    //        trip.event.description
    //        trip.event.time
    //        trip.event.endTime
    //        trip.event.clLocation
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        
        let trip = trips[indexPath.row]
        
        cell.dropOffTimeLabel.text = trip.event.time.prettyTime
        cell.pickUpTimeLabel.text = trip.event.endTime?.prettyTime
        
        if trips[indexPath.row].dropOff == nil  {
            cell.dropOffTimeLabel.textColor = red
        }
        
        if trips[indexPath.row].pickUp == nil {
            cell.pickUpTimeLabel.textColor = red
        }
     
        cell.eventTitleLabel.text = trip.event.description
        
        //we may not need this 3rd label.  Although, it could be used for location...
        cell.descriptionLabel.text = ""
        
        var childNames = ""
        for child in trip.children {
            childNames += ", " + child.name
        }
        cell.kidsLabel.text = childNames
        
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


class EventCell: UITableViewCell {
    
    @IBOutlet weak var dropOffTimeLabel: UILabel!
    @IBOutlet weak var pickUpTimeLabel: UILabel!
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var kidsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
}


    
    
    


