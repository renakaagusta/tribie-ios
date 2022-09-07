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
                .foregroundColor(Color.white)
            HStack{
                VStack(alignment:.leading){
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width:CGFloat(userFrom.count * 10), height: 20)
                            .foregroundColor(Color.primaryColor)
                        AppBody1(text: userFrom, color: Color.white, fontWeight: .semibold)
                    }
                }
                Image(systemName: "arrow.right")
                    .foregroundColor(Color.secondaryColor)
                AppBody1(text: userTo,color: Color.secondaryColor)
                Spacer()
                VStack (alignment:.trailing) {
                    AppBody1(text: "Rp\(amount)", color: Color.secondaryColor, fontWeight: .bold)
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
