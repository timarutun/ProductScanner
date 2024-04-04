//
//  ProductScannerApp.swift
//  ProductScanner
//
//  Created by Timur on 4/3/24.
//

import SwiftUI

@main
struct ProductScannerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
