//
//  Header.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI

struct AppBody1: View {
    var text: String
    var color: Color = Color.black
    var fontWeight: Font.Weight = Font.Weight.light
    var textAlign: TextAlignment = TextAlignment.center
    
    var body: some View {
        Text(text).multilineTextAlignment(textAlign).font(.system(size: 15, weight: fontWeight)).foregroundColor(color)
    }
}

struct AppBody1_Previews: PreviewProvider {
    static var previews: some View {
        AppBody1(text: "You'll need at least 2 members to create")
    }
}
