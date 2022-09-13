//
//  DebtsRankCard.swift
//  tribie
//
//  Created by Arnold Sidiprasetija on 12/09/22.
//

import SwiftUI

struct DebtsRankCard: View {
    @State var startColor : Color = Color.red
    @State var endColor: Color = Color.blue
    @State var rank1 : String
    @State var rank2 : String
    @State var rank3 : String
    @State var debtsRank1 : String
    @State var debtsRank2 : String
    @State var debtsRank3 : String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 18).fill(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 362, height: 152)
            
            HStack{
                VStack{
                    AppTitle1(text: "Debts Rank", color: Color.primaryColor, fontWeight: .semibold, fontSize: 22)
                    AppFootnote(text: "Top 1 in debt better pay the next bill", color: Color.black, fontWeight: .regular, textAlign: .center)
                    VStack(alignment: .leading){
                        HStack{
                            AppTitle1(text: rank1, color: Color.primaryColor, fontWeight: .bold, fontSize: 23).padding(.horizontal)
                            Spacer()
                            AppTitle1(text: "Rp\(debtsRank1)", color: Color.primaryColor, fontWeight: .bold, fontSize: 22).padding(.horizontal)
                        }
                        
                        HStack{
                            AppTitle1(text: rank2, color: Color.primaryColor.opacity(0.7), fontWeight: .regular, fontSize: 16).padding(.horizontal)
                            Spacer()
                            AppTitle1(text: "Rp\(debtsRank2)", color: Color.primaryColor.opacity(0.7), fontWeight: .semibold, fontSize: 16).padding(.horizontal)
                        }
                        
                        HStack{
                            AppTitle1(text: rank3, color: Color.primaryColor.opacity(0.5), fontWeight: .regular, fontSize: 13).padding(.horizontal)
                            Spacer()
                            AppTitle1(text: "Rp\(debtsRank3)", color: Color.primaryColor.opacity(0.5), fontWeight: .semibold, fontSize: 13).padding(.horizontal)
                        }
                    }
                }
            }
        }
    }
}

struct DebtsRankCard_Previews: PreviewProvider {
    static var previews: some View {
        DebtsRankCard(rank1: "Member 1", rank2: "Member 2", rank3: "Member 3", debtsRank1: "25000", debtsRank2: "20000", debtsRank3: "10000")
    }
}
