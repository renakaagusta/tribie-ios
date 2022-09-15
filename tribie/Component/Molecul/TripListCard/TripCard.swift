//
//  TripListCard.swift
//  tribie
//
//  Created by I Gede Bagus Wirawan on 12/09/22.
//
import SwiftUI

struct TripListCard: View {
    @State var title: String
    @State var members: String
    @State var amount: Int
    
    var onClick: () -> Void = {}
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                AppBody1(text: title, color: Color.white, fontWeight: .bold)
                HStack {
                    Image(systemName: "person.2.fill").frame(width: 10, height: 10).foregroundColor(Color.white)
                    AppCaption1(text: members)
                }
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("Total Spending").foregroundColor(.gray)
                Text("Rp" + String(amount)).fontWeight(.bold).foregroundColor(Color.signifierColor)
            }
        }.padding().background(Color.cardColor).cornerRadius(10)
        
    }
}

struct TripListCardView_Previews: PreviewProvider {
    static var previews: some View {
        TripListCard(title: "Liburan tribie", members: "asdas, adsada, assdas", amount: 10000)
    }
}
