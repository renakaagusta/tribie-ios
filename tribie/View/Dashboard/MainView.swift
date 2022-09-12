//
//  TabbarView.swift
//  tribie
//
//  Created by I Gede Bagus Wirawan on 08/09/22.
//

import SwiftUI
import SystemConfiguration


//for TabBarView
struct MainView: View {
    
    @State var tripId: String = AppConstant.DUMMY_DATA_TRIP_ID
    @State var transactionId: String?
    @ObservedObject var tripViewModel = TripViewModel()
    @ObservedObject var settlementListViewModel : SettlementListViewModel = SettlementListViewModel()

    
    var body: some View {
        
        TabView {
            TripView()
                .tabItem {
                    Label("Transaction", systemImage: "scroll.fill")
                }
            
            TransactionListView()
                .tabItem {
                    Label("Drafts", systemImage: "clock.fill")
                }
            
            SettlementListView()
                .tabItem {
                    Label("Settlements", systemImage: "checkmark.seal.fill")
                }
        }.accentColor(Color.primaryColor)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
