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
    

    private var apiKey: String {
        guard let filePath = Bundle.main.path(forResource: "Config", ofType: "plist") else {
            fatalError("Couldn't find file 'Config.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'Config.plist'.")
        }
        return value
    }

    func toggleRecommendations() {
        showingRecommendations.toggle()
    }
    
    func getProductInfo(upc: String, completion: @escaping (Products?) -> Void) {
        let url = URL(string: "https://api.spoonacular.com/food/products/upc/\(upc)?apiKey=\(apiKey)")!
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Ошибка: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Данные не получены")
                completion(nil)
                return
            }
            
            do {
                let products = try JSONDecoder().decode(Products.self, from: data)
                completion(products) 
            } catch {
                print("Ошибка декодирования JSON: \(error)")
                completion(nil)             }
        }
        
        task.resume()
    }
}





