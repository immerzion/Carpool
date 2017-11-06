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
    @IBOutlet weak var locationLabel: UILabel!
    
    var trip: Trip!
    var user: User!
    
    let locationManager = CLLocationManager()
    let savannah = CLLocation(latitude: 32.076176, longitude: -81.088371)
    var userLocation = CLLocation()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        getUserLocation()
        
        //idLabel.text = user.name
        eventDescriptionLabel.text = trip.event.description
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        let tripDate = formatter.string(from: trip.event.time)
        
        timeLabel.text = tripDate
        //locationLabel.text = trip.event.location
        
        
//        //idLabel.text = self.event.
//        eventDescriptionLabel.text = self.event.description
//        timeLabel.text = test
//        locationLabel.text = test
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
