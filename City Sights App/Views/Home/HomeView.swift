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
                            Text(model.placemark?.locality ?? "")
                            Spacer()
                            Button("Switch to Map View") {
                                self.isMapShowing = true
                            }
                        }
                        Divider()
                        
                        ZStack (alignment: .top) {
                            BusinessList()
                            
                            HStack {
                                Spacer()
                                YelpAttribution(link: "https://yelp.com")
                            }
                            .padding(.trailing, -20)
                        }
                    }
                    .padding([.horizontal, .top])
                    .navigationBarHidden(true)
                } else {
                    ZStack (alignment: .top){
                        BusinessMap(selectedBusiness: $selectedBusiness)
                            .ignoresSafeArea()
                            .sheet(item: $selectedBusiness) { business in
                                BusinessDetail(business: business)
                        }
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color.white)
                                .frame(height: 48)
                                .cornerRadius(5)
                            HStack {
                                Image(systemName: "location")
                                Text(model.placemark?.locality ?? "")
                                Spacer()
                                Button("Switch to List View") {
                                    self.isMapShowing = false
                                }
                            }
                            .padding()
                        }
                        .padding()
                    }
                    .navigationBarHidden(true)
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
