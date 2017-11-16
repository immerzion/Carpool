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
    
    //segue variable
    var datasourceToLoad = 0
    //0 = My Trips
    //1 = Friends Trips
    //2 = Unscheduled Trips
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        tableView.estimatedRowHeight = 80
        
        loadDataSource(datasourceToLoad)
    }
    
    //VC needs title.
    // add feature so that update pickup etc is shown when returning to rootVC
    // make seg control friends/user list isHidden when refreshing
    
    
    @IBAction func onRefreshPulled(_ sender: UIRefreshControl) {
        tableView.reloadData()
        tableRefresh.endRefreshing()
    }
    
    @IBAction func onFilterPressed(_ sender: UISegmentedControl) {
        loadDataSource(sender.selectedSegmentIndex)
    }
    
    func loadDataSource(_ data: Int) {
        API.unobserveAllTrips()
        trips.removeAll()
        switch data {
        case 0:
            calTrips()
        case 1:
            friendsTrips()
//        case 2:
//            filteredTrips()
        default:
            break
        }
    }
    
    func calTrips() {
        API.observeMyTripCalendar(sender: self) { (result) in
            switch result {
            case .success(let tripCalendar):
                self.tripCalendar = tripCalendar
                self.trips = tripCalendar.trips
                self.tableView.reloadData()
            case .failure(let error):
                print(#function, error)
            }
        }
    }
    
    func friendsTrips() {
        API.observeTheTripCalendarOfMyFriends(sender: self) { (result) in
            switch result {
            case .success(let trips):
                self.tripCalendar = trips
                self.trips = trips.trips
                self.tableView.reloadData()
            case .failure(let error):
                print(#function, error)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
//        switch eventListSegControl.selectedSegmentIndex {
//        case 0, 1:
//            return 7
//        case 2:
//            return 1
//        default:
//            return 1
//        }
        return 7
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch eventListSegControl.selectedSegmentIndex {
//        case 0, 1:
            guard let rowsInSection = tripCalendar?.dailySchedule(forWeekdayOffsetFromToday: section).trips.count else { return 0 }
            return rowsInSection
//        case 2:
//            return trips.count
//        default:
//            return 1
//        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch eventListSegControl.selectedSegmentIndex {
//        case 0, 1:
        
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                
                guard let title = tripCalendar?.dailySchedule(forWeekdayOffsetFromToday: section).prettyName else { return "" }
                return title
            } else {
                return nil
            }
//        case 2:
//            return "Unscheduled Trips"
//        default:
//            return ""
//        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
//
//        if trips.count > 0 {
//
            //let trip = trips[indexPath.row]
        
        if let trip = tripCalendar?.dailySchedule(forWeekdayOffsetFromToday: indexPath.section).trips[indexPath.row] {
            
            cell.dropOffTimeLabel.text = trip.event.time.prettyTime
            cell.pickUpTimeLabel.text = trip.event.endTime?.prettyTime
            
            if trips[indexPath.row].dropOff == nil  {
                cell.dropOffTimeLabel.textColor = orange
            } else {
                cell.dropOffTimeLabel.textColor = black
            }
            
            if trips[indexPath.row].pickUp == nil {
                cell.pickUpTimeLabel.textColor = orange
            } else {
                cell.pickUpTimeLabel.textColor = black
            }
            
            cell.eventTitleLabel.text = trip.event.description
            
            if trip.comments.count == 0 {
                cell.commentLabel.text = ""
            } else {
                cell.commentLabel.text = "Comments: \(trip.comments.count)"
                cell.commentLabel.textColor = red
            }
            
            
            var childNames = ""
            for child in trip.children {
                childNames += child.name + " "
            }
            cell.kidsLabel.text = childNames
//        }
//        else {
//            cell.dropOffTimeLabel.text = ""
//            //cell.dropOffTimeLabel.isHidden = true
//            cell.dropOffTimeLabel.textColor = black
//
//            cell.pickUpTimeLabel.text = ""
//            //cell.pickUpTimeLabel.isHidden = true
//            cell.pickUpTimeLabel.textColor = black
//
//            cell.eventTitleLabel.text = "No trips scheduled!"
//            cell.kidsLabel.text =  "Relax or have some fun!"
//            cell.commentLabel.text = ""
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
            //let createTripVC = segue.destination as! CreateTripViewController
            //guard let indexPath = tableView.indexPathForSelectedRow else { return }
            //createTripVC.trip = trips[indexPath.row]
        }
    }
    
    
    @IBAction func unwindFromCreateTripVC(segue: UIStoryboardSegue) {
        let createTripVC = segue.source as? CreateTripViewController
        datasourceToLoad = 0
    }
    
    @IBAction func unwindFromTripDetailVC(segue: UIStoryboardSegue) {
        let tripDetailVC = segue.source as? TripDetailViewController
        datasourceToLoad = 0
    }
    
}


class EventCell: UITableViewCell {
    
    @IBOutlet weak var dropOffTimeLabel: UILabel!
    @IBOutlet weak var pickUpTimeLabel: UILabel!
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var kidsLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
}


//    func friendsTrips() {
//        trips.removeAll()
//
//        API.observeTheTripsOfMyFriends(sender: self) { (result) in
//            switch result {
//
//            case .success(let trips):
//                self.trips = trips
//                //print(trips)
//                self.tableView.reloadData()
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }

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

//    func filteredTrips() {
//        API.observeTrips(sender: self, completion: { (result) in
//            switch result {
//            case .success(let trips):
//
//                for trip in trips {
//                    //if trip is fully scheduled...
//                    if trip.pickUp == nil || trip.dropOff == nil {
//                        self.trips.append(trip)
//                        self.tableView.reloadData()
//                    }
//                }
//            case .failure(let error):
//                print(#function, error)
//            }
//        })
//    }









