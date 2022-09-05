//
//  tribieApp.swift
//  tribie
//
//  Created by renaka agusta on 18/08/22.
//

import SwiftUI
import SwiftyBeaver

let Logger = SwiftyBeaver.self
let Console = ConsoleDestination()

@main
struct tribieApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
             ContentView().onAppear {
                Logger.addDestination(Console)
                Logger.debug("TRIBIE APP - DEBUG MDOE")
            }
        }
    }
}
