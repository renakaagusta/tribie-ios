//
//  TripListCard.swift
//  tribie
//
//  Created by I Gede Bagus Wirawan on 12/09/22.
//
import SwiftUI

struct TripListCard<Content: View>: View {
    @State var title: String
    @State var members: String
    @State var amount: Int
    
    var onClick: () -> Void = {}
    
    var body: some View {
        HStack {
            VStack {
                AppBody1(text: title)
                Spacer().frame(width: 10.0)
                HStack {
                    Image(systemName: "person.2.fill")
                    AppCaption1(text: members)
                }
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("Total Spending").foregroundColor(.gray)
                Text("Rp" + String(amount)).fontWeight(.bold).foregroundColor(Color.primaryColor)
            }
        }.padding().cornerRadius(10)
    }
}
