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
    var tripCalendar: API.TripCalendar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        tableView.estimatedRowHeight = 80
        
        //filteredTrips()
        
        calTrips()
    }
    
    //VC needs title.
    //Realtime clock would be nice
    
    //        trip.pickUp?.driver
    //        trip.dropOff?.driver
    //
    //        trip.event.owner.name
    //        trip.event.owner.isMe
    //        trip.event.description
    //        trip.event.time
    //        trip.event.endTime
    //        trip.event.clLocation
    
    // add feature so that update pickup etc is shown when returning to rootVC
    // make seg control friends/user list isHidden when refreshing
    @IBAction func onRefreshPulled(_ sender: UIRefreshControl) {
        tableView.reloadData()
        tableRefresh.endRefreshing()
    }
    
    @IBAction func onFilterPressed(_ sender: UISegmentedControl) {
        API.unobserveAllTrips()
        switch sender.selectedSegmentIndex {
        case 0:
            calTrips()
        case 1:
            friendsTrips()
        case 2:
            filteredTrips()
        default:
            break
        }
    }
    
    //not working after pod update
    func calTrips() {
        trips.removeAll()
        
        API.observeMyTripCalendar(sender: self) { (result) in
            switch result {
            case .success(let trips):
                self.tripCalendar = trips
                self.trips = trips.trips
                //print(trips)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func friendsTrips() {
        trips.removeAll()
        
        API.observeTheTripsOfMyFriends(sender: self) { (result) in
            switch result {
                
            case .success(let trips):
                self.trips = trips
                //print(trips)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func filteredTrips() {
        trips.removeAll()
        
        API.observeTrips(sender: self, completion: { (result) in
            switch result {
            case .success(let trips):
                
                for trip in trips {
                    //if trip is fully scheduled...
                    if trip.pickUp == nil || trip.dropOff == nil {
                        self.trips.append(trip)
                        self.tableView.reloadData()
                    }
                }
            case .failure(let error):
                //TODO
                print(#function, error)
            }
        })
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        switch eventListSegControl.selectedSegmentIndex {
        case 0:
            return 7
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 1
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch eventListSegControl.selectedSegmentIndex {
        case 0:
            guard let rowsInSection = tripCalendar?.dailySchedule(forWeekdayOffsetFromToday: section).trips.count else { return 0 }
            //            if rowsInSection == 0 {
            //                return 1
            //            } else {
            return rowsInSection
        //            }
        case 1:
            return trips.count
        case 2:
            return trips.count
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch eventListSegControl.selectedSegmentIndex {
        case 0:
            guard let title = tripCalendar?.dailySchedule(forWeekdayOffsetFromToday: section).prettyName else { return "" }
            return title
        case 1:
            return "My Friends Trips"
        case 2:
            return "Unscheduled Trips"
        default:
            return ""
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        
        if trips.count > 0 {
            
                let trip = trips[indexPath.row]
            
            cell.dropOffTimeLabel.text = trip.event.time.prettyTime
            cell.pickUpTimeLabel.text = trip.event.endTime?.prettyTime
            
            if trips[indexPath.row].dropOff == nil  {
                cell.dropOffTimeLabel.textColor = red
            } else {
                cell.dropOffTimeLabel.textColor = black
            }
            
            if trips[indexPath.row].pickUp == nil {
                cell.pickUpTimeLabel.textColor = red
            } else {
                cell.pickUpTimeLabel.textColor = black
            }
            
            cell.eventTitleLabel.text = trip.event.description
            
            //we may not need this 3rd label.  Although, it could be used for location...
            cell.descriptionLabel.text = ""
            
            var childNames = ""
            for child in trip.children {
                childNames += child.name + " "
            }
            cell.kidsLabel.text = childNames
        }
        else {
            cell.dropOffTimeLabel.text = ""
            //cell.dropOffTimeLabel.isHidden = true
            cell.dropOffTimeLabel.textColor = black
            
            cell.pickUpTimeLabel.text = ""
            //cell.pickUpTimeLabel.isHidden = true
            cell.pickUpTimeLabel.textColor = black
            
            cell.eventTitleLabel.text = "No trips scheduled!"
            cell.kidsLabel.text =  "Relax or have some fun!"
            cell.descriptionLabel.text = ""
        }
        
        return cell
    }
    
    
    //    func allTrips() {
    //
    //        trips.removeAll()
    //
    //        API.observeTrips(sender: self, completion: { (result) in
    //            switch result {
    //            case .success(let trips):
    //                self.trips = trips
    //                self.tableView.reloadData()
    //            case .failure(let error):
    //                //TODO
    //                print(#function, error)
    //            }
    //        })
    //    }
    
    
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return trips.count
    //    }
    //
    //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
    //
    //        let trip = trips[indexPath.row]
    //
    //        cell.dropOffTimeLabel.text = trip.event.time.prettyTime
    //        cell.pickUpTimeLabel.text = trip.event.endTime?.prettyTime
    //
    //        if trips[indexPath.row].dropOff == nil  {
    //            cell.dropOffTimeLabel.textColor = red
    //        } else {
    //            cell.dropOffTimeLabel.textColor = black
    //        }
    //
    //        if trips[indexPath.row].pickUp == nil {
    //            cell.pickUpTimeLabel.textColor = red
    //        } else {
    //            cell.pickUpTimeLabel.textColor = black
    //        }
    //
    //        cell.eventTitleLabel.text = trip.event.description
    //
    //        //we may not need this 3rd label.  Although, it could be used for location...
    //        cell.descriptionLabel.text = ""
    //
    //        var childNames = ""
    //        for child in trip.children {
    //            childNames += child.name + " "
    //        }
    //        cell.kidsLabel.text = childNames
    //
    //        return cell
    //    }
    
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







