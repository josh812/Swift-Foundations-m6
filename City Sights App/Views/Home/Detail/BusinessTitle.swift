//
//  BusinessTitle.swift
//  City Sights App
//
//  Created by J M on 4/10/22.
//

import SwiftUI

struct BusinessTitle: View {
    var business:Business
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(business.name!)
                .font(.title2)
                .bold()
            
            if business.location?.displayAddress != nil {
                ForEach(business.location!.displayAddress!, id: \.self) { displayLine in
                    Text(displayLine)
                }
            }
            
            Image("regular_\(business.rating ?? 0)")
        }
    }
}
