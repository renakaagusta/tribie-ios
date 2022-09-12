//
//  CircleButton.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

struct ProfileCard<Content: View>: View {
    @State var image: AppCircleImage<Content>
    @State var userName: String
    @State var userMail: String
    @State var backgroundColor: Color = Color.white
    
    var onClick: () -> Void = {}
    
    var body: some View {
        HStack {
            image
            Spacer().frame(width: 10.0)
            VStack {
                Text(userName)
                Text(userMail)
            }
            Spacer()
        }.padding().background(backgroundColor).cornerRadius(10)
    }
}

struct ProfileCard_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCard(image: AppCircleImage(size: 40.0, component: {}), userName: "ProfileCard 1", userMail: "renakaagusta28@gmail.com")
    }
}
