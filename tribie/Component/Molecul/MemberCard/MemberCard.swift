//
//  CircleButton.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

struct MemberCard<Content: View>: View {
    @State var image: AppCircleImage<Content>
    @State var userName: String
    @State var backgroundColor: Color = Color.cardColor
    
    var onClick: () -> Void = {}
    
    var body: some View {
        HStack {
            image
            Spacer().frame(width: 10.0)
            Text(userName)
            Spacer()
            Image(systemName: "chevron.right")
        }.padding().background(backgroundColor).cornerRadius(10)
    }
}

struct MemberCard_Previews: PreviewProvider {
    static var previews: some View {
        MemberCard(image: AppCircleImage(size: 40.0, component: {}), userName: "Member 1")
    }
}
