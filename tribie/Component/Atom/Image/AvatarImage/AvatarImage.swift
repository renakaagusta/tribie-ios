//
//  CircleButton.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

struct AppAvatarImage: View {
    @State var size: Double = 0.0
    @State var url: String = "https://cdn.pixabay.com/photo/2013/07/13/12/07/avatar-159236__340.png"
    @State var source: AppImageSource = AppImageSource.Network
    
    var onClick: () -> Void = {}
    
    var body: some View {
        ZStack {
            AppCircleImage(size: 100.0, url: url, component: {})
            VStack {
                HStack{
                    Spacer()
                    AppCircleButton(size: 20, color: Color.black, onClick: self.onClick)
                }
                Spacer()
            }.frame(height: size)
        }.frame(width: size + 20)
    }
}

struct AppAvatarImage_Previews: PreviewProvider {
    static var previews: some View {
        AppAvatarImage(size: 100.0)
    }
}
