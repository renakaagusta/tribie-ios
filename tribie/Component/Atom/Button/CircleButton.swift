//
//  CircleButton.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

enum AppCircleButtonContentSource {
    case Icon
    case Text
    case Image
}

struct AppCircleButton: View {
    @State var size: Double = 40.0
    @State var icon: Image?
    @State var image: Image?
    @State var text: String?
    @State var color: Color? = Color.primaryColor
    @State var source: AppCircleButtonContentSource = AppCircleButtonContentSource.Image
    
    var onClick: () -> Void = {}
    
    var body: some View {
        Button(action: {
            self.onClick()
        }, label: {
            if(source == AppCircleButtonContentSource.Icon) { icon }
            if(source == AppCircleButtonContentSource.Image) { image }
            if(source == AppCircleButtonContentSource.Text) { Text(text!).foregroundColor(Color.white) }
        }).frame(width: size, height: size).padding().background(color).cornerRadius(40)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
}

struct AppCircleButton_Previews: PreviewProvider {
    static var previews: some View {
        AppCircleButton()
    }
}
