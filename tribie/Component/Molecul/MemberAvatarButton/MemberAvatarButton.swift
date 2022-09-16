//
//  CircleButton.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

struct MemberAvatarButton<Content: View>: View {
    @State var image: AppCircleImage<Content>
    @Binding var selected: Bool
    @State var color: Color = Color.signifierColor
    @State var size: CGFloat = 40
    
    var onClick: () -> Void = {}
    
    var body: some View {
            Button(action: {
                self.onClick()
            }, label: {
                    HStack {
                        AppCircleImage(size: size - 5, component: {})
                    }.frame(width: size, height: size)
                        .overlay(
                            RoundedRectangle(cornerRadius: size/2)
                                .stroke(selected ? color : Color.clear, lineWidth: 2)
                        )
            }).frame(minWidth: size < 1 ? 0.0 : size, idealWidth: size < 1 ? .infinity : size, maxWidth: size < 1 ? .infinity : size, minHeight: size < 0  ? 0 : size, idealHeight: (size < 1) ? 12 : size,  maxHeight: (size < 1) ? 12 : size).background(Color.white)
        
    }
}
//
//struct MemberAvatarButton_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            MemberAvatarButton(image: AppCircleImage(size: 40.0, component: {}), selected: .constant(true))
//        }.frame().background(Color.red)
//    }
//}
