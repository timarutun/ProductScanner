//
//  Product.swift
//  ProductScanner
//
//  Created by Timur on 4/4/24.
//

import Foundation

struct Products: Decodable {
    let title: String
    let importantBadges: [String]
}

