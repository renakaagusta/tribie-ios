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
    @State var month: String
    @State var time: String
    @State var total: Int
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 87)
                .foregroundColor(Color.white)
            HStack{
                VStack(alignment: .leading){
                    Spacer().frame(height: 10)
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: CGFloat(memberPaid.count) * 10,height: 15)
                            .foregroundColor(Color.primaryColor)
                        
                        Text(memberPaid)
                            .font(.system(size: 13))
                    }
                    
                    Spacer().frame(height: 7)
                    
                    Text(title)
                        .font(.system(size: 17))
                        .fontWeight(.regular)
                    
                    Spacer().frame(height: 7)
                    
                    Text("\(month), \(date)")
                        .font(.system(size: 13))
                        .foregroundColor(Color.gray)
                    
                    Spacer().frame(height: 10)
                }
                Spacer()
                VStack(alignment: .trailing){
                    Spacer().frame(height:31)
                    Text("Rp. \(total)")
                        .font(.system(size: 17))
                        .fontWeight(.bold)
                        .foregroundColor(Color.primaryColor)
                    
                    Spacer().frame(height: 7)
                    
                    Text(time)
                        .font(.system(size: 13))
                        .foregroundColor(Color.gray)
                    
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
                              month: "August",
                              time: "9:41",
                              total: 7300000)
    }
}
