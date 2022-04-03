//
//  HomeView.swift
//  City Sights App
//
//  Created by J M on 4/1/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model:ContentModel
    @State var isMapShowing = false
    
    var body: some View {
        if model.restaurants.count != 0 || model.sights.count != 0{
            if !isMapShowing {
                VStack (alignment: .leading){
                    HStack {
                        Image(systemName: "location")
                        Text("Seattle, WA")
                        Spacer()
                        Text("Switch to Map View")
                    }
                    Divider()
                    BusinessList()
                }.padding([.horizontal, .top])
            } else {
                
            }
        } else {
            ProgressView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
