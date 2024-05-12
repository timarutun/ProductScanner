//
//  Product.swift
//  ProductScanner
//
//  Created by Timur on 4/4/24.
//

import Foundation

final class ProductInfoViewModel: ObservableObject {
    
    @Published var foundProducts: Products?
    @Published var showingRecommendations = false
    @Published var upc: String?
    @Published var isPresented = false

    func toggleRecommendations() {
        showingRecommendations.toggle()
    }
    
    // Getting Product info by UPC
    func getProductInfo(upc: String, completion: @escaping (Products?) -> Void) {
        // URL with UPC
        let url = URL(string: "https://api.spoonacular.com/food/products/upc/\(upc)?apiKey=bf70a096ee6f40f4b4612ff67077d3bf")!
        
        // Creating session URLSession
        let session = URLSession.shared
        
        // Creating tast for request
        let task = session.dataTask(with: url) { data, response, error in
            // Checking for errors
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            // Checking if we have any data
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            // Trying to parse data to object with type Products
            do {
                let products = try JSONDecoder().decode(Products.self, from: data)
                completion(products) // If success - Products
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil) // If error - nil
            }
        }
        
        task.resume()
    }
}





