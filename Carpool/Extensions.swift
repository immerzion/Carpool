//
//  Extensions.swift
//  Carpool
//
//  Created by Ernesto Bautista on 11/7/17.
//  Copyright © 2017 Immerzion Interactive. All rights reserved.
//

import Foundation
import MapKit

extension Date {
    var prettyDate: String {
        let day = self
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        let formattedDate = formatter.string(from: day)
        return formattedDate
    }
    
    var prettyTime: String {
        let time = self
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let formattedTime = formatter.string(from: time)
        return formattedTime
    }
    
    var prettyDay: String {
        let day = self
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let formattedDate = formatter.string(from: day)
        return formattedDate
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

extension CLLocation: MKAnnotation {
    public var title: String? {
        return title
    }
    
    public var subtitle: String? {
        return subtitle
    }
}

extension MKPlacemark: MKAnnotation {
    var subtitle: String? {
        return name
    }
    
}

