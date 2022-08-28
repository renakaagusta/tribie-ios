//
//  SpendingCard.swift
//  tribie
//
//  Created by Arnold Sidiprasetija on 26/08/22.
//

import SwiftUI

struct SpendingCard: View {
    
    @State var totalSpending: Int
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 18)
                .frame(width: 362, height: 152)
                .foregroundColor(Color.white)
            
            HStack{
                VStack{
                    Text("Total Spending")
                        .font(.system(size: 28))
                    Spacer().frame(height: 19)
                    Text("Rp. \(totalSpending)")
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .foregroundColor(Color.primaryColor)
                    Spacer().frame(height: 15)
                    Text("on this trip")
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
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
