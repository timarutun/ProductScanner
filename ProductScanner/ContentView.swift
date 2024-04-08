//
//  ContentView.swift
//  ProductScanner
//
//  Created by Timur on 4/3/24.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    @State private var isPresented = false
    @State private var upc: String?
    @State private var foundProducts: Products?
    
    @State private var breackdown: [DataForChart] = [
        .init(name: "Fat", value: 0.5),
        .init(name: "Protein", value: 0.2),
        .init(name: "Carbs", value: 0.1)
    ]
    
    var body: some View {
        NavigationView{
            VStack {
                Form{
                    Section {
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
                    Section(header: Text("Product name")){
                        HStack {
                            Text("\(foundProducts?.title ?? "Title")")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                        }
                    }
                    Section(header: Text("Important Badges")){
                        Text(foundProducts?.importantBadges.joined(separator:", ") ?? "Badges")
                            .font(.callout)
                    }
                    Section {
                        Chart(breackdown) { breackdown in
                            SectorMark(
                                angle: .value(Text(verbatim: breackdown.id), breackdown.value)
                            )
                            .foregroundStyle(
                                            by: .value(
                                                Text(verbatim: breackdown.name),
                                                breackdown.name)
                            )
                        }
                        .frame(width: 250, height: 250, alignment: .center)
                    }
                    
                    Section(header: Text("Nutrients")){
                        Text("Fat: \(String(foundProducts?.nutrition?.caloricBreakdown?.percentFat ?? 0))")
                        Text("Protein: \(String(foundProducts?.nutrition?.caloricBreakdown?.percentProtein ?? 0))")
                        Text("Calories: \(String(foundProducts?.nutrition?.calories ?? 0))")
                        Text("Carbs: \(String(foundProducts?.nutrition?.caloricBreakdown?.percentCarbs ?? 0))")
                            .font(.callout)
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
}

struct DataForChart: Identifiable {
    var id = UUID().uuidString
    let name: String
    let value: Double
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

