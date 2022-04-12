//
//  LaunchView.swift
//  City Sights App
//
//  Created by J M on 3/27/22.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        if model.authorizationState == .notDetermined {
            OnboardingView()
        } else if model.authorizationState == .authorizedWhenInUse || model.authorizationState == .authorizedAlways {
            
            HomeView()
            
        } else {
            LocationDeniedView()
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
