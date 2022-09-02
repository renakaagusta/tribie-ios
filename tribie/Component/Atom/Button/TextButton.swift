//
//  TextButton.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

struct AppTextButton: View {
    @State var color: Color = Color.primaryColor
    @State var label: String = "Button"
    @State var height: Double = 0.0
    @State var width: Double = 0.0
    @State var borderColor: Color = Color.primaryColor
    
    var onClick: () -> Void = {}
    
    var body: some View {
        Button(action: {
            self.onClick()
        }, label: {
            Text(label).foregroundColor(color).padding()
        }).frame(minWidth: width < 1 ? 0.0 : width, idealWidth: width < 1 ? .infinity : width, maxWidth: width < 1 ? .infinity :width, minHeight: height < 0  ? 0 : height, idealHeight: (height < 1) ? 12 : height,  maxHeight: (height < 1) ? 12 : height).padding().background(Color.white)
    }
}

struct AppTextButton_Previews: PreviewProvider {
    static var previews: some View {
        AppTextButton(label: "Button")
    }
}
