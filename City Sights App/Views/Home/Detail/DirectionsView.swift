//
//  DirectionsView.swift
//  City Sights App
//
//  Created by J M on 4/10/22.
//

import SwiftUI

struct DirectionsView: View {
    var business:Business
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                BusinessTitle(business: business)
                Spacer()
                
                if let lat = business.coordinates?.latitude,
                    let long = business.coordinates?.longitude,
                    let name = business.name {
                    Link("Open in Maps", destination: URL(string: "https://maps.apple.com/?ll=\(lat),\(long)&q=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")!)
                }
            }
            .padding()
            
            DirectionsMap(business: business)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}
