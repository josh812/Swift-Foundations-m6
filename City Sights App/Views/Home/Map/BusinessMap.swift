//
//  BusinessMap.swift
//  City Sights App
//
//  Created by J M on 4/3/22.
//

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable {
    @EnvironmentObject var model:ContentModel
    @Binding var selectedBusiness:Business?
    
    var locations:[MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        
        for business in model.restaurants + model.sights {
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.name ?? ""
                
                annotations.append(a)
            }
        }
        
        return annotations
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        
        uiView.showAnnotations(self.locations, animated: true)
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
    }
    
    // MARK: Coordinator Class
    func makeCoordinator() -> Coordinator {
        return Coordinator(map: self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var map:BusinessMap
        
        init(map: BusinessMap) {
            self.map = map
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.annotationReuseID)
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.annotationReuseID)
                
                annotationView!.canShowCallout = true
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                annotationView!.annotation = annotation
            }
            
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            for business in map.model.restaurants + map.model.sights {
                if business.name == view.annotation?.title {
                    map.selectedBusiness = business
                    return
                }
            }
        }
    }
}
