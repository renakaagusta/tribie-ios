//
//  CircleButton.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

struct ItemCard: View {
    @State var fieldName: Binding<String> = .constant("")
    @State var fieldQuantity: Double? = 0.0
//    @State var fieldQuantity: Binding<Double> = .constant(0.0)
    
    var name : String = ""
    var quantity : Int = 0
    
    @State var price: Int
    
    var onChangeName: (_ name: String) -> Void = { name in print(name)}
    var onChangeQuantity: (_ quantity: Int) -> Void = { quantity in print(quantity)}
    var onIncrement: () -> Void = {}
    var onDecrement: () -> Void = {}
    
    var body: some View {
        HStack {
            /*AppTextField(placeholder: "Item Name", field: fieldName).frame(width: 120).onChange(of: fieldName.wrappedValue) { newValue in
            }
            Spacer()*/
            HStack{
                AppOutlinedCircleButton(size: 30.0, icon: Image(systemName: "minus"), color: Color.gray, source: AppOutlinedCircleButtonContentSource.Icon, onClick: onDecrement)
                AppBody1(text: "\(quantity ?? 0)")
                //AppNumberField(placeholder: "Quantity", field: fieldQuantity).frame(width: 40)
                AppOutlinedCircleButton(size: 30.0, icon: Image(systemName: "plus"), color: Color.gray, source: AppOutlinedCircleButtonContentSource.Icon, onClick: onIncrement)
            }
            //Spacer()
            //Text("Rp " + String(price)).fontWeight(.bold).foregroundColor(Color.primaryColor)
        }.padding().cornerRadius(10)
    }
}

struct ItemCard_Previews: PreviewProvider {
    static var previews: some View {
        ItemCard(fieldName: .constant("Item 1"), fieldQuantity: 0.0, price: 1000)
    }
}
