//
//  Divider.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI

struct AppDivider: View {
    @State var height: CGFloat = 1.0
    @State var width: CGFloat = 200.0
    @State var color: Color = Color.gray
    
    var body: some View {
        Spacer().frame(width: width, height: height).background(color)
    }
}

struct AppDivider_Previews: PreviewProvider {
    static var previews: some View {
        AppDivider()
    }
}
