//
//  CircleButton.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

enum AppCircleImageSource{
    case Network
    case Local
    case SystemName
    case Component
}

struct AppCircleImage<Component: View>: View {
    var size: Double
    var url: String
    var source: AppCircleImageSource = AppCircleImageSource.Network
    var component: () -> Component
    
    init(size: CGFloat = 100, url: String = "https://cdn.pixabay.com/photo/2013/07/13/12/07/avatar-159236__340.png", source: AppCircleImageSource = AppCircleImageSource.Network, @ViewBuilder component: @escaping () -> Component) {
        self.size = size
        self.url = url
        self.source = source
        self.component = component
    }
    
    var body: some View {
        ZStack {
            if(source == AppCircleImageSource.Network) {
                AsyncImage(url: URL(string: url)!, placeholder: {
                    Text("Loading...")
                }, width: size, height: size, cornerRadius: size/2)
            }
            if(source == AppCircleImageSource.Local) {
                Image(url).frame(width: size, height: size)
            }
            if(source == AppCircleImageSource.SystemName) {
                Image(systemName: url).frame(width: size, height: size)
            }
            if(source == AppCircleImageSource.Component) {
                component().frame(width: size, height: size)
            }
        }.frame(width: size)
    }
}

struct AppCircleImage_Previews: PreviewProvider {
    static var previews: some View {
        AppCircleImage(size: 100.0, component: {})
    }
}
