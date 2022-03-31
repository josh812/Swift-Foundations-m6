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
    
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
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
            
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
            getBusinesses(category: Constants.restaurantsKey, location: userLocation!)
        }
    }
    
    // MARK: Yelp API Methods
    func getBusinesses(category: String, location: CLLocation) {
        let urlString = "\(Constants.APIURL)?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
        let URL = URL(string: urlString)
        
        guard URL != nil else {
            return
        }
        
        var request = URLRequest(url: URL!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.addValue("Bearer \(Constants.APIKEY)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let result = try decoder.decode(BusinessSearch.self, from: data!)
                
                DispatchQueue.main.async {
                    switch category {
                    case Constants.sightsKey:
                        self.sights = result.businesses
                    
                    case Constants.restaurantsKey:
                        self.sights = result.businesses
                        
                    default:
                        break
                    }
                }
            } catch {
                print(error)
            }
        }
        
        dataTask.resume()
    }
}
