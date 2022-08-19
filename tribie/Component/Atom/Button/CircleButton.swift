//
//  CircleButton.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

struct AppCircleButton: View {
    @State var size: Double = 40.0
    @State var icon: Image?
    @State var text: String?
    
    var onClick: () -> Void = {}
    
    var body: some View {
        Button(action: {
           
        }, label: {
            if(icon != nil) { icon }
            if((text) != nil) { Text(text!).foregroundColor(Color.white) }
        }).frame(width: size, height: size).padding().background(Color.primaryColor).cornerRadius(40)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
}

struct AppCircleButton_Previews: PreviewProvider {
    static var previews: some View {
        AppCircleButton()
    }
}
