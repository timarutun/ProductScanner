//
//  NotFoundView.swift
//  ProductScanner
//
//  Created by Timur on 5/9/24.
//

import SwiftUI

struct NotFoundView: View {
    var body: some View {
        VStack {
            Text("Sorry")
                .font(.title)
            
            Text("we couldn't find that item")
                .font(.title2)
            Text("🤷‍♂️")
                .font(.system(size: 10))
        }
            .navigationTitle("")
        
    }
}

#Preview {
    NotFoundView()
}
