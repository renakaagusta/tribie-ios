//
//  CircleButton.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

struct AppRadio: View {
    @State var selected: Bool = false
    @State var size: Double = 40.0
    @State var color: Color = Color.black
    
    var onClick: () -> Void = {}
    
    var body: some View {
        HStack {
            if(selected) {
                RoundedRectangle(cornerRadius: size / 2, style: .continuous)
                    .fill(color).padding(8.0)
            }
        }.frame(width: size, height: size)
            .overlay(
                RoundedRectangle(cornerRadius: size/2)
                    .stroke(color, lineWidth: 5)
            )
    }
}

struct AppRadio_Previews: PreviewProvider {
    static var previews: some View {
        AppRadio()
    }
}
