//
//  DestinationViewController.swift
//  Carpool
//
//  Created by Ernesto Bautista on 11/8/17.
//  Copyright © 2017 Immerzion Interactive. All rights reserved.
//

import Foundation
import UIKit
import MapKit


protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}


class DestinationViewController: UIViewController {
    
    @IBOutlet weak var confirmButton: UIButton!
    // hide until location is selected
    // confirm button segue to destination outlet text field
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    var selectedPin:MKPlacemark? = nil
    
    var resultSearchController:UISearchController? = nil
    
    var searchText = ""
    var searchResult = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    @IBAction func onConfirmPressed(_ sender: UIButton) {
        print(selectedPin?.title)
    }
    
    func getDirections(){
        if let selectedPin = selectedPin {
            let mapItem = MKMapItem(placemark: selectedPin)
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            mapItem.openInMaps(launchOptions: launchOptions)
        }
    }
    
//    func search(for query: String) {
//        let searchRequest = MKLocalSearchRequest()
//        searchRequest.naturalLanguageQuery = query
//
//        let search = MKLocalSearch(request: searchRequest)
//        search.start { (response, error) in
//            if let response = response {
//                //print(response.mapItems)
//
//                self.mapView.addAnnotations(response.mapItems)
//
//                //                for mapItem in response.mapItems {
//                //                    print(mapItem.placemark.title, mapItem.placemark.subtitle)
//                //                    self.mapView.addAnnotation(mapItem.placemark)
//                //                }
//            }
//        }
//    }
//}

//extension DestinationViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
//        //guard let userCoordinate = userLocation.location?.coordinate else { return }
//        //zoom level
//        let coordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 10000, 10000)
//        mapView.setRegion(coordinateRegion, animated: true)
//
//        search(for: "pizza")
//    }
//}
    
}


extension DestinationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }
        mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

//extension MKMapItem: MKAnnotation {
//    public var coordinate: CLLocationCoordinate2D {
//        return placemark.coordinate
//    }
//    
//    public var title: String? {
//        return name
//    }
//    
//    public var subtitle: String? {
//        return phoneNumber
//    }
//}

extension DestinationViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "(city) (state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.02, 0.02)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
}

extension DestinationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
                //guard let userCoordinate = userLocation.location?.coordinate else { return }
                //zoom level
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 10000, 10000)
                mapView.setRegion(coordinateRegion, animated: true)
            }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.orange
        pinView?.canShowCallout = true
//        let smallSquare = CGSize(width: 30, height: 30)
//        let button = UIButton(frame: CGRect(origin: CGPointZero, size: smallSquare))
//        button.setBackgroundImage(UIImage(named: "car"), for: .Normal)
//        button.addTarget(self, action: "getDirections", for: .touchUpInside)
//        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
}


