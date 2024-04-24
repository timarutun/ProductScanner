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
                        Toggle("Show Product Photo", isOn: $showingProductPhoto.animation())

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
                    Section(header: Text("Important Badges")){
                        Text(foundProducts?.importantBadges.joined(separator:", ") ?? "Badges")
                            .font(.callout)
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
                }
                .navigationBarTitle("Poduct Info")
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

