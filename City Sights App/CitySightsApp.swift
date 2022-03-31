//
//  CitySightsApp.swift
//  City Sights App
//
//  Created by J M on 3/27/22.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
