//
//  Location.swift
//  CaseStudy-BilalYalcin
//
//  Created by Bilal Yalcin on 14.11.2022.
//

import Foundation
import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    var latitude: Double!
    var longitude: Double!
}
