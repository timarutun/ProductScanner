//
//  ProductDetailView.swift
//  ProductScanner
//
//  Created by Timur on 5/9/24.
//

import SwiftUI
import Charts

struct ProductDetailView: View {
    let product: Products
    @Binding var showingRecommendations: Bool
    @State private var isShowingImageDetail = false

    var body: some View {
        if product.title != nil {
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(product.title ?? "Title")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("Calories: \(String(format: "%.1f", product.nutrition?.calories ?? 0))")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray)
                    }
                    .padding()
                    
                    Spacer()
                    
                    ProductImageView(product: product, isShowingImageDetail: $isShowingImageDetail)
                }
                
                Button(action: {
                    showingRecommendations.toggle()
                }) {
                    RecommendationButtonView(showingRecommendations: showingRecommendations)
                }
                .padding(.top, 10)
                
                if showingRecommendations {
                    Text(product.generatedText ?? "")
                        .font(.body)
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                }
                
                Divider()
                
                // Nutrients Section
                Section(header: Text("Nutrients").font(.title3).foregroundStyle(.gray)) {
                    if let nutrition = product.nutrition {
                        let breakdown: [DataForChart] = [
                            .init(name: "Fat", value: nutrition.caloricBreakdown?.percentFat ?? 0, color: .orange),
                            .init(name: "Protein", value: nutrition.caloricBreakdown?.percentProtein ?? 0, color: .blue),
                            .init(name: "Carbs", value: nutrition.caloricBreakdown?.percentCarbs ?? 0, color: .purple)
                        ]
                        
                        Chart(breakdown) { data in
                            SectorMark(
                                angle: .value(Text(data.name), data.value), innerRadius: .ratio(0.5), angularInset: 5
                            )
                            .foregroundStyle(data.color)
                        }
                        .frame(height: 300)
                        
                        Text("Fat: \(String(format: "%.1f", nutrition.caloricBreakdown?.percentFat ?? 0))%")
                            .foregroundStyle(.orange)
                        
                        Text("Protein: \(String(format: "%.1f", nutrition.caloricBreakdown?.percentProtein ?? 0))%")
                            .foregroundStyle(.blue)
                        
                        Text("Carbs: \(String(format: "%.1f", nutrition.caloricBreakdown?.percentCarbs ?? 0))%")
                            .font(.callout)
                            .foregroundStyle(.purple)
                    } else {
                        Text("Nutrition information not available")
                    }
                }
                .padding(.bottom, 15)
                .fontWeight(.bold)
                
                Divider()
                
                // Ingredients Section
                Section(header: Text("Ingredients").font(.title3).fontWeight(.bold).foregroundStyle(.gray).padding(.bottom)) {
                    if let ingredients = product.ingredients {
                        ForEach(ingredients, id: \.name) { ingredient in
                            
                            // MARK: - safety level not showing but giving color to name
                            VStack(alignment: .leading) {
                                
                                if let safetyLevel = ingredient.safetyLevel {
                                    Text(ingredient.name)
                                        .foregroundColor(safetyLevel == "high" ? .green : .red)
                                        .font(.subheadline)
                                }
                                else {
                                    Text(ingredient.name)
                                        .foregroundColor(.green)
                                        .font(.subheadline)
                                }
                                if let description = ingredient.description {
                                    Text("Description: \(description)")
                                        .foregroundColor(.gray)
                                        .font(.subheadline)
                                }
                            }
                            Divider()
                            // MARK: - Safety level showing
//                            VStack(alignment: .leading) {
//                                Text(ingredient.name)
//                                    .foregroundColor(.primary)
//                                if let safetyLevel = ingredient.safetyLevel {
//                                    Text("Safety Level: \(safetyLevel)")
//                                        .foregroundColor(safetyLevel == "high" ? .green : .red)
//                                        .font(.subheadline)
//                                }
//                                else {
//                                    Text("Safety Level: Unknown")
//                                        .foregroundColor(.gray)
//                                        .font(.subheadline)
//                                }
//                                if let description = ingredient.description {
//                                    Text("Description: \(description)")
//                                        .foregroundColor(.gray)
//                                        .font(.subheadline)
//                                }
//                            }
                            .padding(.vertical, 4)
                        }
                    } else {
                        VStack {
                            Image(systemName: "info.circle")
                                .font(.system(size: 36))
                                .foregroundColor(.gray)
                            Text("Ingredients not available")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        } else {
            NotFoundView()
        }
    }
}

struct ProductImageView: View {
    let product: Products
    @Binding var isShowingImageDetail: Bool

    var body: some View {
        Button(action: {
            isShowingImageDetail.toggle()
        }) {
            if let imageURL = URL(string: product.image ?? "") {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: 100, height: 100)
                } placeholder: {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: 100, height: 100)
                }
                .padding()
            }
        }
        .sheet(isPresented: $isShowingImageDetail) {
            if let imageURL = URL(string: product.image ?? "") {
                ImageView(imageURL: imageURL)
            }
        }
    }
}

struct RecommendationButtonView: View {
    let showingRecommendations: Bool

    var body: some View {
        HStack {
            Spacer()

            Text("Product Analysis")

            Spacer()

            if showingRecommendations {
                Image(systemName: "chevron.up")
            } else {
                Image(systemName: "chevron.down")
            }
        }
        .font(.headline)
        .fontWeight(.bold)
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
        .padding(.horizontal, 15)
        .padding(.vertical, 8)
        .background(Color.green)
        .cornerRadius(10)
    }
}
