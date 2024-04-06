//
//  ContentView.swift
//  ProductScanner
//
//  Created by Timur on 4/3/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented = false
    @State private var upc: String?
    @State private var foundProducts: Products?
    
    
    var body: some View {
        NavigationView{
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
                    Section(header: Text("Nutrients")){
                        Text("Fat: \(String(foundProducts?.nutrition?.fat ?? "0"))")
                        Text("Protein: \(String(foundProducts?.nutrition?.protein ?? "0"))")
                        Text("Calories: \(String(foundProducts?.nutrition?.calories ?? 0))")
                        Text("Carbs: \(String(foundProducts?.nutrition?.carbs ?? "0"))")
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
