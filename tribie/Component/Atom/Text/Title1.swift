//
//  Header.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI

struct AppTitle1: View {
    var text: String
    var color: Color = Color.black
    var fontWeight: Font.Weight = Font.Weight.medium
    
    var body: some View {
        Text(text).font(.system(size: 28, weight: fontWeight)).foregroundColor(color)
    }
}

struct AppTitle1_Previews: PreviewProvider {
    static var previews: some View {
        AppTitle1(text: "You'll need at least 2 members to create")
    }
}
