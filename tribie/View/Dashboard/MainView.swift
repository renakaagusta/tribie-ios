//
//  TabbarView.swift
//  tribie
//
//  Created by I Gede Bagus Wirawan on 08/09/22.
//

import SwiftUI
import SystemConfiguration

struct MainView: View {
    
    @State var tripId: String
    
    var body: some View {
        
        TabView {
            TripView(tripId: tripId)
                .tabItem {
                    Label("Transaction", systemImage: "scroll.fill")
                }
            
            TransactionListView(tripId: tripId)
                .tabItem {
                    Label("Drafts", systemImage: "clock.fill")
                }
            
            SettlementListView(tripId: tripId)
                .tabItem {
                    Label("Settlements", systemImage: "checkmark.seal.fill")
                }
        }.accentColor(Color.signifierColor)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(tripId: "")
    }
}
