//
//  Link.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

struct AppLink: View {
    @State var label: String = "Button"
    @State var height: Double = 0.0
    @State var width: Double = 0.0
    @State var color: Color = Color.gray
    //@State var image: AppImage = AppImage(height: 40.0, width: 40.0, url: "arrow.right", source: AppImageSource.SystemName,color: Color.gray, component: {})
    
    var onClick: () -> Void = {}
    
    var body: some View {
        HStack {
            Text(label).foregroundColor(color).padding()
            
        }
    }
}

struct AppLink_Previews: PreviewProvider {
    static var previews: some View {
        AppLink(label: "Button")
    }
}
