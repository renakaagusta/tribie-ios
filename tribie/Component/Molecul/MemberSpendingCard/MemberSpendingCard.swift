//
//  CircleButton.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

struct MemberSpendingCard<Content: View>: View {
    @State var image: AppCircleImage<Content>
    @State var userName: String
    @State var amount: Int
    
    var onClick: () -> Void = {}
    
    var body: some View {
        HStack {
            image
            Spacer().frame(width: 10.0)
            Text(userName)
            Spacer()
            VStack(alignment: .trailing) {
                Text("Spent").foregroundColor(.gray)
                Text("Rp " + String(amount)).fontWeight(.bold).foregroundColor(Color.primaryColor)
            }
        }.padding().cornerRadius(10)
    }
}

struct MemberSpendingCard_Previews: PreviewProvider {
    static var previews: some View {
        MemberSpendingCard(image: AppCircleImage(size: 40.0, component: {}), userName: "Member 1", amount: 10000)
    }
}
