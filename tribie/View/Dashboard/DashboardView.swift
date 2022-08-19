//
//  DashboardView.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

struct DashboardView: View {
    @State var selection: Tab = .pet
        
    enum Tab{
        case pet
        case journal
        case medical
    }
        
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
        
    var body: some View {
            TabView(selection: $selection){
                ScreenView()
                    .tabItem{
                        Label("Screen 1", systemImage: "heart.fill")
                    }
                    .tag(Tab.pet)
                ScreenView()
                    .tabItem{
                        Label("Screen 2", systemImage: "heart.fill")
                    }
                    .tag(Tab.journal)
                ScreenView()
                    .tabItem{
                        Label("Screen 3", systemImage: "heart.fill")
                    }
                    .tag(Tab.medical)
            }
        }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView().preferredColorScheme(scheme)
    }
}
