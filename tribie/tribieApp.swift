//
//  tribieApp.swift
//  tribie
//
//  Created by renaka agusta on 18/08/22.
//

import SwiftUI

@main
struct tribieApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            TripView()
        }
    }
}
