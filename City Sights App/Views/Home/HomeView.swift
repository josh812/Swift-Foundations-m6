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
    @State var selectedBusiness:Business?
    
    var body: some View {
        if model.restaurants.count != 0 || model.sights.count != 0 {
            NavigationView {
                if !isMapShowing {
                    VStack (alignment: .leading){
                        HStack {
                            Image(systemName: "location")
                            Text("Seattle, WA")
                            Spacer()
                            Button("Switch to Map View") {
                                self.isMapShowing = true
                            }
                        }
                        Divider()
                        BusinessList()
                    }
                    .padding([.horizontal, .top])
                    .navigationBarHidden(true)
                } else {
                    BusinessMap(selectedBusiness: $selectedBusiness)
                        .ignoresSafeArea()
                        .sheet(item: $selectedBusiness) { business in
                            BusinessDetail(business: business)
                        }
                }
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
