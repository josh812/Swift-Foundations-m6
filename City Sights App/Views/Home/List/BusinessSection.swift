//
//  BusinessSection.swift
//  City Sights App
//
//  Created by J M on 4/2/22.
//

import SwiftUI

struct BusinessSection: View {
    var title:String
    var businesses: [Business]
    
    var body: some View {
        Section (header: BusinessSectionHeader(title: title)) {
            ForEach(businesses) { business in
                BusinessRow(business: business)
            }
        }
    }
}
