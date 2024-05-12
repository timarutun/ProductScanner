//
//  ContentView.swift
//  ProductScanner
//
//  Created by Timur on 4/3/24.
//

import SwiftUI
import Charts

struct ProductInfoView: View {
    @StateObject private var viewModel = ProductInfoViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    if let product = viewModel.foundProducts {
                        ProductDetailView(product: product, showingRecommendations: $viewModel.showingRecommendations)
                    } else {
                        WelcomeTextView()
                    }
                }
            }
            .padding()
            .navigationBarTitle("NutriScope")
            
        }
        .overlay(alignment: .bottom) {
            BarcodeScannerButton(isPresented: $viewModel.isPresented, upc: $viewModel.upc, foundProducts: $viewModel.foundProducts)
        }
    }
}

struct DataForChart: Identifiable {
    var id = UUID().uuidString
    let name: String
    let value: Double
    let color: Color
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductInfoView()
    }
}
