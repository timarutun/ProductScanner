//
//  BarcodeScannerButton.swift
//  ProductScanner
//
//  Created by Timur on 5/9/24.
//

import SwiftUI

struct BarcodeScannerButton: View {
    @Binding var isPresented: Bool
    @Binding var upc: String?
    @Binding var foundProducts: Products?

    var body: some View {
        HStack {
            Spacer()
            Button {
                isPresented.toggle()
            } label: {
                Image(systemName: "barcode.viewfinder")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .padding(15)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
            .sheet(isPresented: $isPresented) {
                BarCodeScanner(upc: $upc, foundProducts: $foundProducts)
            }
        }
        .padding(.horizontal, 25)
    }
}

