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
        NavigationView{
                Form{
                    Section(header: Text("Product name")){
                        HStack {
                            Text("\(foundProducts?.title ?? "Title")")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                        }
                    }
                    Section {
                       
                        Button(action: {
                                showingProductPhoto.toggle()
                            }) {
                                HStack {
                                    Text(showingProductPhoto ? "Hide Product Photo" : "Show Product Photo")
                                    Spacer()
                                    Image(systemName: (showingProductPhoto ? "chevron.down" : "chevron.up"))
                                }
                                .foregroundStyle(.foreground)
                            }

                                        if showingProductPhoto {
                                            AsyncImage(url: URL(string: foundProducts?.image ?? "")) { image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .clipShape(Rectangle())
                                            } placeholder: {
                                                Rectangle()
                                                    .foregroundStyle(.background)
                                            }
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        }
                    }
                    
                    Section(header: Text("Nutrients")){
                        let breackdown: [DataForChart] = [
                            .init(name: "Fat", value: foundProducts?.nutrition?.caloricBreakdown?.percentFat ?? 30, color: .orange),
                            .init(name: "Protein", value: foundProducts?.nutrition?.caloricBreakdown?.percentProtein ?? 30, color: .blue),
                            .init(name: "Carbs", value: foundProducts?.nutrition?.caloricBreakdown?.percentCarbs ?? 30, color: .purple)
                        ]
                        
                         Chart(breackdown) { breackdown in
                            SectorMark(
                                angle: .value(Text(verbatim: breackdown.id), breackdown.value), innerRadius: .ratio(0.5), angularInset: 5
                            )
                            .foregroundStyle(breackdown.color)
                             
                        }
                         .frame(height: 300)
                            
                        Text("Fat: \(String(foundProducts?.nutrition?.caloricBreakdown?.percentFat ?? 0))")
                            .foregroundStyle(.orange)
                        Text("Protein: \(String(foundProducts?.nutrition?.caloricBreakdown?.percentProtein ?? 0))")
                            .foregroundStyle(.blue)
                        Text("Carbs: \(String(foundProducts?.nutrition?.caloricBreakdown?.percentCarbs ?? 0))")
                            .font(.callout)
                            .foregroundStyle(.purple)
                        Text("Calories: \(String(foundProducts?.nutrition?.calories ?? 0))")
                            .fontWeight(.bold)
                    }
                    
                    Section(header: Text("Ingredients")){
                        if foundProducts == nil {
                                                Text("Loading...")
                                            } else {
                                                ForEach(foundProducts?.ingredients ?? [], id: \.name) { ingredient in
                                                    VStack(alignment: .leading) {
                                                        Text(ingredient.name)
                                                        if let safetyLevel = ingredient.safetyLevel {
                                                            Text("Safety Level: \(safetyLevel)")
                                                                .foregroundColor(safetyLevel == "high" ? .green : .red)
                                                        } else {
                                                            Text("Safety Level: Unknown")
                                                                .foregroundColor(.gray)
                                                        }
                                                    }
                                                }
                                            }
                    }
                    
                }
                .navigationBarTitle("NutriScope")
                .navigationBarItems(trailing:
                                        Button(action: {
                    self.isPresented.toggle()
                }) {
                    Image(systemName: "barcode")
                }.sheet(isPresented: $isPresented) {
                    BarCodeScanner(upc: $upc, foundProducts: $foundProducts)
                }
                )

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

