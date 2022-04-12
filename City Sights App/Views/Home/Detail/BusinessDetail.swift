//
//  BusinessDetail.swift
//  City Sights App
//
//  Created by J M on 4/3/22.
//

import SwiftUI

struct BusinessDetail: View {
    var business:Business
    @State private var showDirections = false
    
    var body: some View {
        VStack (alignment: .leading) {
            VStack (alignment: .leading, spacing: 0) {
                GeometryReader()  { geo in
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                }
                .ignoresSafeArea(.all, edges: .top)
                
                ZStack (alignment: .leading){
                    Rectangle()
                        .frame(height: 36)
                        .foregroundColor(business.isClosed! ? Color.gray : Color.blue)
                    
                    Text(business.isClosed! ? "Closed" : "Open")
                        .foregroundColor(Color.white)
                        .bold()
                        .padding(.leading)
                }
            }
            
            Group {
                BusinessTitle(business: business)
                    .padding()
                
                Divider()
                
                HStack {
                    Text("Phone:")
                        .bold()
                    Text(business.displayPhone ?? "")
                    Spacer()
                    Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                }
                .padding()
                
                Divider()
                
                HStack {
                    Text("Reviews:")
                        .bold()
                    Text(String(business.reviewCount ?? 0))
                    Spacer()
                    Link("Read", destination: URL(string: business.url ?? "")!)
                }
                .padding()
                
                Divider()
                
                HStack {
                    Text("Website:")
                        .bold()
                    Text(business.url ?? "")
                        .lineLimit(1)
                    Spacer()
                    Link("Visit", destination: URL(string: business.url ?? "")!)
                }
                .padding()
                
                Divider()
            }
            
            Button {
                showDirections = true
            } label: {
                ZStack {
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(Color.blue)
                        .cornerRadius(10)
                    
                    Text("Get Directions")
                        .foregroundColor(Color.white)
                        .bold()
                }
            }
            .padding()
            .sheet(isPresented: $showDirections) {
                showDirections = false
            } content: {
                DirectionsView(business: business)
            }

        }
    }
}
