//
//  Event.swift
//  LocalBuzz
//
//  Created by Shweta Ambarkhane on 13/10/24.
//


import Foundation
import CoreLocation

struct Event: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var location: CLLocationCoordinate2D
    var time: Date
}