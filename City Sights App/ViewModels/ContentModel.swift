//
//  ContentModel.swift
//  City Sights App
//
//  Created by J M on 3/29/22.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus == .authorizedAlways
            || locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else if locationManager.authorizationStatus == .denied {
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
    }
}
