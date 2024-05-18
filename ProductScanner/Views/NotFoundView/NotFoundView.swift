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
            Spacer()
            VStack(alignment: .leading) {
                Text("SORRY")
                    .font(.system(size: 70, design: .monospaced))
                    .fontWeight(.ultraLight)
                
                Text("we couldn't find that item")
                    .font(.system(size: 30))
                    .fontWeight(.light)
            }
            .padding(.bottom)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 5)
            
            
            Text("🤷‍♂️")
                .font(.system(size: 100))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 50)
            Spacer()
        }
        .padding(.bottom, 100)
        .navigationTitle("")
    }
}

#Preview {
    NotFoundView()
}
