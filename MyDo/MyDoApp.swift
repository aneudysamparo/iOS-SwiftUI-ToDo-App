//
//  MyDoApp.swift
//  MyDo
//
//  Created by Aneudys Amparo on 27/4/23.
//

import SwiftUI

@main
struct MyDoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
