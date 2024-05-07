//
//  ContentView.swift
//  ProductScanner
//
//  Created by Timur on 4/3/24.
//

import SwiftUI
import Charts
// Добавь ТипКит потом



struct ContentView: View {
    @State private var showingProductPhoto = false
    @State private var isPresented = false
    @State private var upc: String?
    @State private var foundProducts: Products?
    @State private var isShowingImageDetail = false
    @State private var showingRecommendations = false


    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    if let product = foundProducts {
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
                            
                            Button(action: {
                                    self.isShowingImageDetail.toggle()
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
                        
                        Button(action: {
                            self.showingRecommendations.toggle()
                        }) {
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
                        .padding(.top, 10)
                        if showingRecommendations {
                            Text(foundProducts?.generatedText ?? "")
                                .font(.body)
                                .foregroundColor(.black)
                                .padding(.vertical, 10)
                        }
                        
                        Divider()
                        
                        Section(header: Text("Nutrients").font(.footnote).foregroundStyle(.gray)) {
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
                        
                        Section(header: Text("Ingredients").font(.footnote).fontWeight(.bold).foregroundStyle(.gray)) {
                            if let ingredients = foundProducts?.ingredients {
                                ForEach(ingredients, id: \.name) { ingredient in
                                    VStack(alignment: .leading) {
                                        Text(ingredient.name)
                                            .foregroundColor(.primary)
                                        if let safetyLevel = ingredient.safetyLevel {
                                            Text("Safety Level: \(safetyLevel)")
                                                .foregroundColor(safetyLevel == "high" ? .green : .red)
                                                .font(.subheadline)
                                        } else {
                                            Text("Safety Level: Unknown")
                                                .foregroundColor(.gray)
                                                .font(.subheadline)
                                        }
                                        if let description = ingredient.description {
                                            Text("Description: \(description)")
                                                .foregroundColor(.gray)
                                                .font(.subheadline)
                                        }
                                    }
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
                        
                    } else {
                        WelcomeTextView()
                        
                    }
                    
                }
                
            }
            .ignoresSafeArea()
            .padding()
            .navigationBarTitle("NutriScope")
            
            
        }
        .overlay(alignment: .bottom) {
            
            HStack {
                Spacer()
                Button {
                    self.isPresented.toggle()
                } label: {
                    Image(systemName: "barcode.viewfinder")
                        .resizable() // Разрешить изменение размера изображения
                        .frame(width: 35, height: 35) // Установить размер изображения
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
}

struct DataForChart: Identifiable {
    var id = UUID().uuidString
    let name: String
    let value: Double
    let color: Color
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
