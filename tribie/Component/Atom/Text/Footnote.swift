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
    var textAlign: TextAlignment = TextAlignment.center
    
    var body: some View {
        Text(text).multilineTextAlignment(textAlign).font(.system(size: 13, weight: fontWeight)).foregroundColor(color).frame(alignment:.leading)
    }
}

struct AppFootnote_Previews: PreviewProvider {
    static var previews: some View {
        AppFootnote(text: "Add a new transaction to this group", textAlign: TextAlignment.leading)
    }
}
