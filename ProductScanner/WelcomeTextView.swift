//
//  WelcomeTextView.swift
//  ProductScanner
//
//  Created by Timur on 5/1/24.
//

import SwiftUI

struct WelcomeTextView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            SectionView(title: "Welcome to Nutriscope!", color: .blue, isTitle: true) {
                Text("Your ultimate companion for healthier choices.")
            }
            
            SectionView(systemName: "play.circle.fill", title: "How it works:", color: .green) {
                Text("Simply scan the barcode of any product and discover its nutritional breakdown, ingredients, and their safety levels.")
            }
            
            SectionView(systemName: "heart.circle.fill", title: "Empower yourself:", color: .red) {
                Text("Make informed choices about what you consume. Understand the nutritional content and safety of products before you buy them.")
            }
            
            SectionView(systemName: "shield.fill", title: "Stay safe:", color: .blue) {
                Text("Our app analyzes ingredient safety levels so you can prioritize products that align with your health and safety standards.")
            }
            
            Spacer()
            
            Text("Tap on green button to scan the barcode")
                .font(.footnote)
                .padding(.leading)
                .frame(maxWidth: .infinity)
                .foregroundColor(.primary)
        }
        .padding(.top, 20)
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct SectionView<Content: View>: View {
    var systemName: String?
    var title: String
    var color: Color
    var isTitle: Bool = false
    var content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if isTitle {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.leading)
            } else {
                HStack {
                    Image(systemName: systemName ?? "")
                        .foregroundColor(color)
                        .font(.title)
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                }
                .padding(.leading)
            }
            
            content()
                .padding(.horizontal)
                .font(.subheadline)
        }
        .padding(.vertical)
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    WelcomeTextView()
}
