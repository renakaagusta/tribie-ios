//
//  Header.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI

struct AppHeadline1: View {
    var text: String
    var color: Color = Color.black
    var fontWeight: Font.Weight = Font.Weight.medium
    var fontSize: CGFloat = 17
    
    var body: some View {
        Text(text).font(.system(size: fontSize, weight: fontWeight)).foregroundColor(color)
    }
}

struct AppHeadline1_Previews: PreviewProvider {
    static var previews: some View {
        AppHeadline1(text: "Recent Transaction")
    }
}
