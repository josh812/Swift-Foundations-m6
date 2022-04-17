//
//  YelpAttribution.swift
//  City Sights App
//
//  Created by J M on 4/12/22.
//

import SwiftUI

struct YelpAttribution: View {
    var link:String
    
    var body: some View {
        Link(destination: URL(string: link)!) {
            Image("yelp")
                .resizable()
                .scaledToFit()
                .frame(height: 36)
        }
    }
}
