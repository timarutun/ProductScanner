//
//  Product.swift
//  ProductScanner
//
//  Created by Timur on 4/4/24.
//

import Foundation

class ProductSearchManager {
    
    // Функция для получения информации о продукте по его UPC
    func getProductInfo(upc: String, completion: @escaping (Products?) -> Void) {
        // Создаем URL для запроса, используя переданный UPC
        let url = URL(string: "https://api.spoonacular.com/food/products/upc/\(upc)?apiKey=bf70a096ee6f40f4b4612ff67077d3bf")!
        
        // Создаем сессию URLSession
        let session = URLSession.shared
        
        // Создаем задачу для выполнения запроса
        let task = session.dataTask(with: url) { data, response, error in
            // Проверяем, есть ли какие-либо ошибки
            if let error = error {
                print("Error: \(error)")
                completion(nil) // В случае ошибки вызываем блок завершения с nil
                return
            }
            
            // Проверяем, получили ли мы какие-либо данные
            guard let data = data else {
                print("No data received")
                completion(nil) // В случае отсутствия данных вызываем блок завершения с nil
                return
            }
            
            // Пытаемся распарсить полученные данные в объект типа Products
            do {
                let products = try JSONDecoder().decode(Products.self, from: data)
                completion(products) // В случае успешного распарсивания вызываем блок завершения с объектом Products
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil) // В случае ошибки при распарсивании вызываем блок завершения с nil
            }
        }
        
        // Начинаем выполнение задачи
        task.resume()
    }
}



