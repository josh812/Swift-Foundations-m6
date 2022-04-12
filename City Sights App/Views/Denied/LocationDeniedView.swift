//
//  LocationDeniedView.swift
//  City Sights App
//
//  Created by J M on 4/11/22.
//

import SwiftUI

struct LocationDeniedView: View {
    private let backgroundColor = Color(red: 34/255, green: 141/255, blue: 138/255)
    
    var body: some View {
        VStack (spacing: 20) {
            Spacer()
            Text("Whoops!")
                .bold()
                .font(.title)
            Text("We need to access your location to provide you with the best sights in the city. You can change your decision at any time in Settings.")
            Spacer()
            Button {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    
                    Text("Go to Settings")
                        .bold()
                        .foregroundColor(backgroundColor)
                        .padding()
                }
            }
            .padding()
            Spacer()
        }
        .padding()
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
        .background(backgroundColor)
        .ignoresSafeArea(.all, edges: .all)
    }
}

struct LocationDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDeniedView()
    }
}
