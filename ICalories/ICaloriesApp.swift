//
//  ICaloriesApp.swift
//  ICalories
//
//  Created by user226765 on 9/15/22.
//

import SwiftUI

@main
struct ICaloriesApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
