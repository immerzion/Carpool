//
//  Extensions.swift
//  Carpool
//
//  Created by Ernesto Bautista on 11/7/17.
//  Copyright © 2017 Immerzion Interactive. All rights reserved.
//

import UIKit
import MapKit

let tbBlue = UIColor(red: 0/255, green: 173/255, blue: 239/255, alpha: 1.0) /* #00adef */
let jessBlue = UIColor(red: 76/255, green: 185/255, blue: 255/255, alpha: 1.0) /* #4cb9ff */
let green = UIColor(red: 76/255, green: 212/255, blue: 102/255, alpha: 1.0) /* #4cd466 */ //iOS Green
let yellow = UIColor(red: 255/255, green: 204/255, blue: 0/255, alpha: 1.0) /* #ffcc00 */
let red = UIColor(red: 246/255, green: 23/255, blue: 81/255, alpha: 1.0) /* #f61751 */
let purple = UIColor(red: 163/255, green: 81/255, blue: 235/255, alpha: 1.0) /* #a351eb */
let black = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0) /* #000000 */

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


//extension UILabel {
//    var alignTop
//}


extension MKMapItem: MKAnnotation {
    public var coordinate: CLLocationCoordinate2D {
        return placemark.coordinate
    }

    public var title: String? {
        return name
    }

    public var subtitle: String? {
        return phoneNumber
    }
}

//extension CLPlacemark: MKAnnotation {
//    public var coordinate: CLLocationCoordinate2D {
//        return placemark.coordinate
//    }
//
//
//}

//extension CLPlacemark {
//    var cityState: String? {
//        if let city = self.locality, let state = self.administrativeArea {
//            return "\(city), \(state)"
//        } else {
//            return nil
//        }
//    }
//}

extension CLLocation {
    public var mkName: String? {
        return MKPlacemark(coordinate: self.coordinate).name
    }
}


extension CLLocation: MKAnnotation {
    public var title: String? {
        return self.title
    }
    
    public var subtitle: String? {
        return self.subtitle
    }
}


extension MKPlacemark: MKAnnotation {
    var subtitle: String? {
        return name
    }
}

