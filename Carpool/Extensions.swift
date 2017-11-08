//
//  Extensions.swift
//  Carpool
//
//  Created by Ernesto Bautista on 11/7/17.
//  Copyright © 2017 Immerzion Interactive. All rights reserved.
//

import Foundation

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

