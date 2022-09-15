//
//  RecentTransactionCard.swift
//  tribie
//
//  Created by Arnold Sidiprasetija on 26/08/22.
//

import SwiftUI

struct RecentTransactionCard: View {
    
    @State var memberPaid: String
    @State var title: String
    @State var date: String
    @State var time: String
    @State var total: Int
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 87)
                .foregroundColor(Color.cardColor)
            HStack{
                VStack(alignment: .leading){
                    Spacer().frame(height: 10)
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.capsuleStart, Color.capsuleEnd]), startPoint: .bottomTrailing, endPoint: .topLeading))
                            .frame(width: CGFloat(memberPaid.count) * 10,height: 15)
                        
                        Text(memberPaid)
                            .font(.system(size: 13))
                            .foregroundColor(Color.signifierColor)
                    }
                    
                    Spacer().frame(height: 7)
                    
                    Text(title)
                        .font(.system(size: 17))
                        .fontWeight(.regular)
                        .foregroundColor(Color.primaryColor)
                    
                }
                Spacer()
                VStack(alignment: .trailing){
                    Spacer().frame(height:10)
                    
                    HStack {
                        Text("\(date)")
                            .font(.system(size: 13))
                            .foregroundColor(Color.textColor)
                        
                        Text(time)
                            .font(.system(size: 13))
                            .foregroundColor(Color.footnoteColor)
                    }
                    
                    Spacer().frame(height:5)
                    
                    Text("Rp\(total)")
                        .font(.system(size: 17))
                        .fontWeight(.bold)
                        .foregroundColor(Color.signifierColor)
                    
                    Spacer().frame(height: 10)
                }
            }
            .padding()
        }

    }
}

struct RecentTransactionCard_Previews: PreviewProvider {
    static var previews: some View {
        RecentTransactionCard(memberPaid: "Kaka",
                              title: "Cak Har",
                              date: "24",
                              time: "9:41",
                              total: 7300000)
    }
}
