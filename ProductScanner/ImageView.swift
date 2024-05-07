//
//  ImageView.swift
//  ProductScanner
//
//  Created by Timur on 5/4/24.
//

import SwiftUI
import Foundation

struct ImageView: View {
    let imageURL: URL
    
    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            default:
                ProgressView()
            }
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}
