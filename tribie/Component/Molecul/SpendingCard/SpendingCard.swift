//
//  SpendingCard.swift
//  tribie
//
//  Created by Arnold Sidiprasetija on 26/08/22.
//

import SwiftUI

struct SpendingCard: View {
    
    @State var totalSpending: Int
    @State var startColor: Color = Color.red
    @State var endColor: Color = Color.blue
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 18).fill(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 362, height: 152)
            
            HStack{
                VStack{
                    AppTitle1(text: "Total Spending", fontWeight: .semibold, fontSize: 22)
                    
                    AppFootnote(text: "on this trip", color: Color.primaryColor, fontWeight: .regular)
                    
                    AppHeader(text: String(totalSpending), color: Color.primaryColor, fontWeight: .bold)
                        .padding(1)
                }
            }
        }
    }
}

struct SpendingCard_Previews: PreviewProvider {
    static var previews: some View {
        SpendingCard(totalSpending: 60000)
    }
}
