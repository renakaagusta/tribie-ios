//
//  CircleButton.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

struct MemberSelectCard<Content: View>: View {
    @State var image: AppCircleImage<Content>
    @State var userName: String
    @State var backgroundColor: Color = Color.white
    
    var onClick: () -> Void = {}
    
    var body: some View {
        HStack {
            AppRadio(selected: false, size: 30.0, color: Color.gray)
            Spacer().frame(width: 15)
            HStack {
                image
                Spacer().frame(width: 10.0)
                Text(userName)
                Spacer()
            }.padding().background(backgroundColor).cornerRadius(10)
        }.padding()
    }
}

struct MemberSelectCard_Previews: PreviewProvider {
    static var previews: some View {
        MemberSelectCard(image: AppCircleImage(size: 40.0, component: {}), userName: "Member 1")
    }
}
