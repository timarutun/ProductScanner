//
//  ContentView.swift
//  ProductScanner
//
//  Created by Timur on 4/3/24.
//

import SwiftUI
import Charts

struct ContentView: View {
    @State private var showingProductPhoto = false
    @State private var isPresented = false
    @State private var upc: String?
    @State private var foundProducts: Products?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    if let product = foundProducts {
                        HStack {
                            Text(product.title ?? "Title")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding()
                            
                            Spacer()
                            
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
                                
                                Text("Fat: \(nutrition.caloricBreakdown?.percentFat ?? 0)")
                                    .foregroundStyle(.orange)
                                Text("Protein: \(nutrition.caloricBreakdown?.percentProtein ?? 0)")
                                    .foregroundStyle(.blue)
                                Text("Carbs: \(nutrition.caloricBreakdown?.percentCarbs ?? 0)")
                                    .font(.callout)
                                    .foregroundStyle(.purple)
                                Text("Calories: \(nutrition.calories ?? 0)")
                                    .fontWeight(.bold)
                            } else {
                                Text("Nutrition information not available")
                            }
                        }
                        .padding(.bottom, 15)
                        .fontWeight(.bold)
                        
                        Divider()
                        
                        Section(header: Text("Ingredients").font(.footnote).foregroundStyle(.gray)) {
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
                        Text("Loading...")
                            .padding()
                    }
                }
                
            }
            .padding()
            .navigationBarTitle("Product Info")
            .navigationBarItems(trailing:
                Button(action: {
                    self.isPresented.toggle()
                }) {
                    Image(systemName: "barcode")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .sheet(isPresented: $isPresented) {
                    BarCodeScanner(upc: $upc, foundProducts: $foundProducts)
                }
            )
        }
        .ignoresSafeArea()
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
