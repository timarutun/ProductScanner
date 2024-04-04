//
//  ProductSearchManager.swift
//  ProductScanner
//
//  Created by Timur on 4/4/24.
//

import Foundation

class ProductSearchManager {
    
    
    func getProductInfo(upc: String, completion: @escaping (Products)-> Void) {
    
        let sessionConfig = URLSessionConfiguration.default

        // Create session, and optionally set a URLSessionDelegate. */
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)

         //Create the Request:
         
                
                let url = "https://api.spoonacular.com/food/products/upc/\(upc)?apiKey=bf70a096ee6f40f4b4612ff67077d3bf"
                guard let apiUrl = URL(string: url) else {
                    return
                }


        // Start a new Task
        let task = session.dataTask(with: apiUrl, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                guard let jsonData = data else {return}
                do{
                    let bookData = try JSONDecoder().decode(Products.self, from: jsonData)
                    completion(bookData)
           }catch{
               print(error)
           }
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
}


protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}



