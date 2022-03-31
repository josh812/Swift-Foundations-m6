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
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else if locationManager.authorizationStatus == .denied {
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.first
        
        if userLocation != nil {
            locationManager.stopUpdatingLocation()
            
//            getBusinesses(category: "arts", location: userLocation!)
            getBusinesses(category: "restaurants", location: userLocation!)
        }
    }
    
    // MARK: Yelp API Methods
    func getBusinesses(category: String, location: CLLocation) {
        let urlString = "https:api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
        let URL = URL(string: urlString)
        
        guard URL != nil else {
            return
        }
        
        var request = URLRequest(url: URL!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.addValue("Bearer sIif6iSpJqxqJYumVjS8tsgDchhH97l8BDlYiiYR7A4Oc-_I-HasKNhgNY73nitLTtxIEL4vgcKR_bAU_KoCSAoqRBQYUISV0r58wAfMfb46p3nnRlyKpPkoRvpEYnYx", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            if error == nil {
                print(response ?? "No Response")
            }
        }
        
        dataTask.resume()
    }
}
