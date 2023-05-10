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
    let locationManager: CLLocationManager

    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            status = .authorizedWhenInUse
            locationManager.requestLocation()
            break
            
        case .restricted:
            status = .restricted
            manager.requestWhenInUseAuthorization()
            break
            
        case .denied:
            status = .denied
            manager.requestWhenInUseAuthorization()
            break
            
        case .notDetermined:
            status = .notDetermined
            manager.requestWhenInUseAuthorization()
            break
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.requestWhenInUseAuthorization()
    }
    
    
}
