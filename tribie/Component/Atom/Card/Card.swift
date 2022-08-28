//
//  Card.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

struct AppCard<Content: View>: View {
    @State var width: CGFloat = 300
    @State var height: CGFloat = 300
    @State var cornerRadius: CGFloat = 20
    @State var backgroundColor: Color = Color.clear
    @State var borderColor: Color = Color.gray
    @State var background: Image?
    var content: () -> Content?
    
    init(width: CGFloat = 300, height: CGFloat = 300, cornerRadius: CGFloat = 20, backgroundColor: Color = Color.clear, borderColor: Color = Color.white, @ViewBuilder component: @escaping () -> Content?) {
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.content = component
    }
    
    var body: some View {
        VStack(){
            if (content != nil) {
                content()
            }
        }.frame(width: width, height: height).overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(lineWidth: 1).foregroundColor(borderColor)
        ).background(RoundedRectangle(cornerRadius: cornerRadius).fill(backgroundColor))
    }
}

struct AppCard_Previews: PreviewProvider {
    static var previews: some View {
        AppCard(component: {VStack{}})
    }
}

