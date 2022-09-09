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
    @ObservedObject var tripViewModel = TripViewModel()
    @ObservedObject var settlementListViewModel : SettlementListViewModel = SettlementListViewModel()

    
    var body: some View {
        
        TabView {
            TripView()
                .tabItem {
                    Label("Transaction", systemImage: "scroll.fill")
                }
            
            SettlementListView()
                .tabItem {
                    Label("Settlements", systemImage: "check.mark.fill")
                }
        }.accentColor(Color.primaryColor)
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
