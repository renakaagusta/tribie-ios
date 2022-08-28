//
//  Header.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI

struct AppFootnote: View {
    var text: String
    var color: Color = Color.gray
    var fontWeight: Font.Weight = Font.Weight.thin
    
    var body: some View {
        Text(text).font(.system(size: 15, weight: fontWeight)).foregroundColor(color)
    }
}

struct AppFootnote_Previews: PreviewProvider {
    static var previews: some View {
        AppFootnote(text: "Add a new transaction to this group")
    }
}
