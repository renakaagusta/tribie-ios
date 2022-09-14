//
//  SettlementCard.swift
//  tribie
//
//  Created by Arnold Sidiprasetija on 26/08/22.
//

import SwiftUI

struct SettlementCard: View {
    
    @State var userFrom: String
    @State var userTo: String
    @State var amount: Int
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .frame(maxWidth:.infinity)
                .frame(height: 48)
                .foregroundColor(Color.cardColor)
            HStack{
                VStack(alignment:.leading){
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.capsuleStart, Color.capsuleEnd]), startPoint: .bottomTrailing, endPoint: .topLeading))
                            .frame(width:CGFloat(userFrom.count * 10), height: 20)
                        AppBody1(text: userFrom, color: Color.signifierColor, fontWeight: .semibold)
                    }
                }
                Image(systemName: "arrow.right")
                    .foregroundColor(Color.textColor)
                AppBody1(text: userTo,color: Color.primaryColor)
                Spacer()
                VStack (alignment:.trailing) {
                    AppBody1(text: "Rp\(amount)", color: Color.primaryColor, fontWeight: .bold)
                        .frame(alignment:.trailing)
                }
            }
            .padding()
        }
    }
}

struct SettlementCard_Previews: PreviewProvider {
    static var previews: some View {
        SettlementCard(userFrom: "Arnold",
                       userTo: "Kaka",
                       amount: 20000)
    }
}
