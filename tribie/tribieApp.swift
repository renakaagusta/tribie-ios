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
            SplitBillView().onAppear {
                Logger.addDestination(Console)
                Logger.verbose("not so important")  // prio 1, VERBOSE in silver
                Logger.debug("something to debug")  // prio 2, DEBUG in green
                Logger.info("a nice information")   // prio 3, INFO in blue
                Logger.warning("oh no, that won’t be good")  // prio 4, WARNING in yellow
                Logger.error("ouch, an error did occur!")  // prio 5, ERROR in red
            }
        }
    }
}
