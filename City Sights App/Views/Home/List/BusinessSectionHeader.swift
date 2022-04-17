//
//  BusinessSectionHeader.swift
//  City Sights App
//
//  Created by J M on 4/2/22.
//

import SwiftUI

struct BusinessSectionHeader: View {
    var title:String
    
    var body: some View {
        ZStack (alignment: .leading){
            Rectangle()
                .foregroundColor(Color.white)
                .frame(height: 45)
            
            Text(title)
                .font(.headline)
        }
    }
}
