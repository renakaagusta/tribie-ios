//
//  Loading.swift
//  tribie
//
//  Created by renaka agusta on 04/09/22.
//

import SwiftUI

struct AppLoading: View {
    var color: Color = Color.primaryColor
    var scale: CGFloat = 3.0
    
    var body: some View {
        ProgressView()
            .scaleEffect(scale, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: color))
    }
}

struct AppLoading_Previews: PreviewProvider {
    static var previews: some View {
        AppLoading()
    }
}
