//
//  ElevatedButton.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

struct AppElevatedButton: View {
    @State var label: String = "Button"
    @State var height: Double = 0
    @State var width: Double = 0
    @State var color: Color = Color.white
    @State var backgroundColor: Color = Color.primaryColor
    
    var onClick: () -> Void = {}
    
    var body: some View {
        Button(action: {
            self.onClick()
        }, label: {
            Text(label).fontWeight(.semibold).foregroundColor(color).padding()
        }).frame(minWidth: width < 1 ? 0.0 : width, idealWidth: width < 1 ? .infinity : width, maxWidth: width < 1 ? .infinity :width, minHeight: height < 0  ? 0 : height, idealHeight: (height < 1) ? 12 : height,  maxHeight: (height < 1) ? 12 : height).padding().background(backgroundColor).cornerRadius(10)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
}

struct AppElevatedButton_Previews: PreviewProvider {
    static var previews: some View {
        AppElevatedButton(label: "Button")
    }
}
