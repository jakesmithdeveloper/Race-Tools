//
//  RaceToolsApp.swift
//  RaceTools
//
//  Created by Jake Smith on 4/29/22.
//

import SwiftUI

@main
struct RaceToolsApp: App {
    
    @StateObject var dataController: DataController
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
    
    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }
}
