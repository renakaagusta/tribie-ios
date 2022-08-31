//
//  SettlementListView.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI

struct settlement: Identifiable {
    var id: Int
    var userform: String
    var userTo: String
    var amount: Int
}

struct SettlementListView: View {
    
    let settlementList: [settlement] = [
        settlement(id: 1, userform: "Arnold", userTo: "Kaka", amount: 230000),
        settlement(id: 2, userform: "Gus", userTo: "Kaka", amount: 204000),
        settlement(id: 3, userform: "Kaka", userTo: "Kaka", amount: 230000),
        settlement(id: 4, userform: "Winnie", userTo: "Kaka", amount: 240000),
        settlement(id: 5, userform: "Nold", userTo: "Kaka", amount: 250000),
    ]
    
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                AppImageButton(image: AppImage(url:"exclamationmark.circle",  source: AppImageSource.SystemName, component: {}))
                
                AppTitle1(text: "Settlement")
                
                ForEach(settlementList) { sett in
                    SettlementCard(userFrom: sett.userform,
                                   userTo: sett.userTo,
                                   amount: sett.amount)
                }
                
                Spacer()
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                AppImageButton(height: 30, width: 30, image: AppImage(height: 24, width: 19, url: "square.and.arrow.up.circle", source: AppImageSource.SystemName, color: Color.primary, component: {}))
            )
            .padding()
        }
        
    }
}

struct SettlementListView_Previews: PreviewProvider {
    static var previews: some View {
        SettlementListView().preferredColorScheme(scheme)
    }
}
