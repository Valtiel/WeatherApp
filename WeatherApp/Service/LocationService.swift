//
//  LocationService.swift
//  WeatherApp
//
//  Created by César Rosales on 09/05/2023.
//

import Foundation

import Foundation
import CoreLocation

class LocationService : NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var status: CLAuthorizationStatus?
    @Published var location: CLLocation?
    let locationManager: CLLocationManager
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.status = manager.authorizationStatus
        switch status {
        case .authorizedWhenInUse:
            locationManager.requestLocation()
            break
            
        case .restricted, .denied, .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.requestWhenInUseAuthorization()
    }
    
    
}
