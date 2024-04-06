//
//  Product.swift
//  ProductScanner
//
//  Created by Timur on 4/4/24.
//

import Foundation

struct Products: Decodable {
    let title: String?
    let importantBadges: [String]
    let nutrition: Nutrition?
    let image: String?
}

// MARK: - Nutrition
struct Nutrition: Codable {
    let nutrients: [Nutrient]
    let caloricBreakdown: CaloricBreakdown?
    let calories: Double?
    let fat, protein, carbs: String?
}

// MARK: - Nutrient
struct Nutrient: Codable {
    let name: String?
    let amount: Double?
    let unit: String?
    let percentOfDailyNeeds: Double?
}

// MARK: - CaloricBreakdown
struct CaloricBreakdown: Codable {
    let percentProtein, percentFat, percentCarbs: Double?
}

