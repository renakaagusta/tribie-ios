//
//  Button.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

enum AppImageSource{
    case Network
    case Local
    case SystemName
    case Component
}

struct AppImage<Component: View>: View {
    @State var height: Double = 0.0
    @State var width: Double = 0.0
    @State var cornerRadius: Double = 0.0
    @State var color: Color = Color.black
    @State var url: String = ""
    @State var source: AppImageSource = AppImageSource.Network
    var component: () -> Component?
    
    init(height: CGFloat = 100, width: CGFloat = 100, url: String = "https://cdn.pixabay.com/photo/2013/07/13/12/07/avatar-159236__340.png", source: AppImageSource = AppImageSource.Network, color: Color = Color.black, @ViewBuilder component: @escaping () -> Component?) {
        self.height = height
        self.width = width
        self.color = color
        self.url = url
        self.source = source
        self.component = component
    }
    
    var body: some View {
        ZStack {
            if(source == AppImageSource.Network) {
                AsyncImage(url: URL(string: url)!, placeholder: {
                    Text("Loading...")
                }, width: width, height: height, cornerRadius: cornerRadius)
            }
            if(source == AppImageSource.Local) {
                Image(url).frame(width: width, height: height)
            }
            if(source == AppImageSource.SystemName) {
                Image(systemName: url).frame(width: width, height: height).foregroundColor(color)
            }
            if(source == AppImageSource.Component) {
                component().frame(width: width, height: height)
            }
        }.frame(width: width, height: height)
    }
}

struct AppImage_Previews: PreviewProvider {
    static var previews: some View {
        AppImage(height: 40.0, width: 100.0, component: {})
    }
}
