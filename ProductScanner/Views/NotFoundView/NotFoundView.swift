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
            VStack(alignment: .leading) {
                Text("SORRY")
                    .font(.system(size: 70, design: .monospaced))
                    .fontWeight(.ultraLight)
                
                Text("we couldn't find that item")
                    .font(.system(size: 30, design: .monospaced))
                    .fontWeight(.light)
            }
            .padding(.bottom)
            Text("🤷‍♂️")
                .font(.system(size: 100))
        }
        .padding(.bottom, 100)
        .navigationTitle("")
        
    }
}

#Preview {
    NotFoundView()
}
