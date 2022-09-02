//
//  Header.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI

struct AppCaption1: View {
    var text: String
    var color: Color = Color.gray
    var fontWeight: Font.Weight = Font.Weight.thin
    var fontSize: CGFloat = 13
    
    var body: some View {
        Text(text).font(.system(size: fontSize, weight: fontWeight)).foregroundColor(color)
    }
}

struct AppCaption1_Previews: PreviewProvider {
    static var previews: some View {
        AppCaption1(text: "13:00 PM")
    }
}
