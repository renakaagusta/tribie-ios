//
//  NumberField.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

struct AppNumberField: View {
    @State var placeholder = "Search..."
    @Binding var field: Double
    @State var image = ""
    @State var numberInput = false
    @State var isFocus = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                if(image != "") {
                    Image(systemName: "magnifyingglass")
                }
                TextField(placeholder, value: $field, formatter: NumberFormatter()).frame(minWidth:0).frame(minWidth: 0, maxWidth: .infinity, minHeight: 8, maxHeight: 8)
                    .keyboardType(numberInput ? .decimalPad : .default)
            }.padding()
            Divider()
                .frame(height: 0.5)
        }
    }
}

