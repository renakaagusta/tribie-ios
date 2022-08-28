//
//  Header.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI

struct AppHeader: View {
    var text: String
    var color: Color = Color.black
    var fontWeight: Font.Weight = Font.Weight.bold
    
    var body: some View {
        Text(text).font(.system(size: 34, weight: fontWeight)).foregroundColor(color)
    }
}

struct AppHeader_Previews: PreviewProvider {
    static var previews: some View {
        AppHeader(text: "Settlements")
    }
}
