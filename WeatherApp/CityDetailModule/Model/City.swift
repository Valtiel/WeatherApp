//
//  City.swift
//  WeatherApp
//
//  Created by César Rosales on 09/05/2023.
//

import Foundation

enum City: Hashable {
    case name(String)
    case location(lat: Double, lon: Double)
}
