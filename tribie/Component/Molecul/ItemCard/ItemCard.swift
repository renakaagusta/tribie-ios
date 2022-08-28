//
//  CircleButton.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

struct ItemCard: View {
    @State var fieldName: Binding<String> = .constant("")
    @State var fieldQuantity: Binding<String> = .constant("")
    
    @State var price: Int
    
    var onIncrement: () -> Void = {}
    var onDecrement: () -> Void = {}
    
    var body: some View {
        HStack {
            AppTextField(placeholder: "Item Name", field: fieldName).frame(width: 120)
            Spacer()
            HStack{
                AppOutlinedCircleButton(size: 30.0, icon: Image(systemName: "minus"), color: Color.gray, source: AppOutlinedCircleButtonContentSource.Icon)
                AppTextField(placeholder: "Quantity", field: fieldQuantity).frame(width: 40)
                AppOutlinedCircleButton(size: 30.0, icon: Image(systemName: "plus"), color: Color.gray, source: AppOutlinedCircleButtonContentSource.Icon)
            }
            Spacer()
            Text("Rp " + String(price)).fontWeight(.bold).foregroundColor(Color.primaryColor)
        }.padding().cornerRadius(10)
    }
}

struct ItemCard_Previews: PreviewProvider {
    static var previews: some View {
        ItemCard(fieldName: .constant("Item 1"), fieldQuantity: .constant(String(0)), price: 1000, onIncrement: {}, onDecrement: {})
    }
}
