//
//  ContentView.swift
//  tribie
//
//  Created by renaka agusta on 18/08/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        VStack {
            AuthView()
        }.environment(\.locale, .init(identifier: "id"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
