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
                Section(header: Text("Product name")){
                    Text("\(foundProducts?.title ?? "Title")")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                }
                Section(header: Text("Important Badges")){
                    Text(foundProducts?.importantBadges.joined(separator:", ") ?? "Badges")
                        .font(.callout)
                }
                Section(header: Text("Nutrients")){
                    Text("Fat:")
                    Text("Protein:")
                    Text("Calories:")
                    Text("Carbohydrates:")
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
                BarCodeScanner(isbn: $upc, foundProducts: $foundProducts)
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
