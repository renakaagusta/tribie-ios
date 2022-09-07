//
//  CircleButton.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

enum AppOutlinedCircleButtonContentSource {
    case Icon
    case Text
    case Image
}

struct AppOutlinedCircleButton: View {
    @State var size: Double = 40.0
    @State var icon: Image?
    @State var image: Image?
    @State var text: String?
    @State var color: Color? = Color.primaryColor
    @State var source: AppOutlinedCircleButtonContentSource = AppOutlinedCircleButtonContentSource.Image
    
    var onClick: () -> Void = {}
    
    var body: some View {
        Button(action: {
            self.onClick()
        }, label: {
            HStack {
                if(source == AppOutlinedCircleButtonContentSource.Icon) { icon.foregroundColor(color)
                }
                if(source == AppOutlinedCircleButtonContentSource.Image) { image }
                if(source == AppOutlinedCircleButtonContentSource.Text) { Text(text!).foregroundColor(Color.white) }
            }.frame(width: size, height: size).overlay(
                RoundedRectangle(cornerRadius: size)
                    .stroke(color!, lineWidth: 2))
        })
    }
}

struct AppOutlinedCircleButton_Previews: PreviewProvider {
    static var previews: some View {
        AppOutlinedCircleButton()
    }
}
