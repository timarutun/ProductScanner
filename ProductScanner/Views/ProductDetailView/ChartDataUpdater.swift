//
//  ChartDataUpdater.swift
//  ProductScanner
//
//  Created by Timur on 5/18/24.
//

import SwiftUI

class ChartDataUpdater: ObservableObject {
    @Published var breakdown: [DataForChart] = []
    
    func updateBreakdownData(nutrition: Nutrition) {
        let newBreakdown: [DataForChart] = [
            .init(name: "Fat", value: nutrition.caloricBreakdown?.percentFat ?? 0, color: .orange),
            .init(name: "Protein", value: nutrition.caloricBreakdown?.percentProtein ?? 0, color: .blue),
            .init(name: "Carbs", value: nutrition.caloricBreakdown?.percentCarbs ?? 0, color: .purple)
        ]
        
        self.breakdown = newBreakdown
    }
}
