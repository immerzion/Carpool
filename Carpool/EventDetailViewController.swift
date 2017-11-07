//
//  EventDetailViewController.swift
//  Carpool
//
//  Created by Jess Telmanik on 11/6/17.
//  Copyright © 2017 Immerzion Interactive. All rights reserved.
//

import UIKit
import CarpoolKit
import CoreLocation

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeOfDayLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dropOffLabel: UILabel!
    @IBOutlet weak var pickUpLabel: UILabel!
    
    var trip: Trip!
    var user: User!
    
    //test
    
    let locationManager = CLLocationManager()
    let savannah = CLLocation(latitude: 32.076176, longitude: -81.088371)
    var userLocation = CLLocation()
    

    // update to tableview instead of uiview

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        let tripDate = formatter.string(from: trip.event.time)
        // change so it shows set date for particular event
        
        formatter.dateFormat = "h:mm a"
        let tripTime = formatter.string(from: trip.event.time)
        // change so it shows set time for particular event
        
        idLabel.text = "Frank"
        timeOfDayLabel.text = tripTime
        eventDescriptionLabel.text = trip.event.description
        timeLabel.text = tripDate
        locationLabel.text = "location"
        //dropOffLabel.text = trip.dropOff
        
        
    }
    
    
    
    
    
    
    
    
    
    
    func alertUserToEnableLocationServices() {
        
        let errorMessage = "Please enable Location Services in the Settings app."
        // create the alert
        let alert = UIAlertController(title: "Nice Weather", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: openSettings))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func openSettings(alert: UIAlertAction) -> Void {
        UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
    }
    
}


extension EventDetailViewController: CLLocationManagerDelegate {
    
    func getUserLocation() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            alertUserToEnableLocationServices()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location")
        //TODO
        //errorDetected(title: "Cannot Load Data", temp: "", summary: "")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("didChangeAuthorization .notDetermined")
            alertUserToEnableLocationServices()
        case .restricted, .denied:
            alertUserToEnableLocationServices()
        case .authorizedAlways, .authorizedWhenInUse:
            getUserLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations[0]
        print("location found!", locations[0])
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(locations.last!, completionHandler: onReverseGeocodeCompleted)
        
        //requestForecast(for: userLocation, completion: onForecastDownloaded)
    }
    
    //called by location manager
    func onReverseGeocodeCompleted(placemarks: [CLPlacemark]?, error: Error?) {
        if let cityState = placemarks?.first?.cityState {
            //navTitleBar.title = cityState
        }
        else {
            //TODO
            //errorDetected(title: "Missing Data", temp: "", summary: "")
            
        }
    }
}


extension CLPlacemark {
    var cityState: String? {
        if let city = self.locality, let state = self.administrativeArea {
            return "\(city), \(state)"
        } else {
            return nil
        }
    }
}
