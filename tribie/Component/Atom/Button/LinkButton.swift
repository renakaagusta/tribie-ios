//
//  ImageButton.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

struct AppLinkButton: View {
    @State var label: String = "Button"
    @State var height: Double = 0.0
    @State var width: Double = 0.0
    @State var color: Color = Color.gray
    @State var image: AppImage = AppImage(height: 40.0, width: 40.0, url: "arrow.right", source: AppImageSource.SystemName,color: Color.gray, component: {})
    
    var onClick: () -> Void = {}
    
    var body: some View {
        Button(action: {
            self.onClick()
        }, label: {
            Text(label).foregroundColor(color).padding()
            image
        }).frame(minWidth: width < 1 ? 0.0 : width, idealWidth: width < 1 ? .infinity : width, maxWidth: width < 1 ? .infinity :width, minHeight: height < 0  ? 0 : height, idealHeight: (height < 1) ? 12 : height,  maxHeight: (height < 1) ? 12 : height).padding().background(Color.white)
    }
}

struct AppLinkButton_Previews: PreviewProvider {
    static var previews: some View {
        AppLinkButton(label: "Button")
    }
}
