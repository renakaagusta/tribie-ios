//
//  CircleButton.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

struct MemberItemCard: View {
    @State var name: String
    @State var quantity: Int
    
    var onIncrement: () -> Void = {}
    var onDecrement: () -> Void = {}
    
    var body: some View {
        HStack {
            HStack {
                AppRadio(selected: false, size: 30, color: Color.gray)
                Spacer().frame(width: 15.0)
                VStack(alignment: .leading) {
                    Text(name).font(.title)
                    Spacer().frame(height: 2)
                    HStack {
                        Text("Remaining").fontWeight(.bold).foregroundColor(.gray)
                        Text(String(quantity)).fontWeight(.bold).foregroundColor(Color.primaryColor)
                    }
                }
            }
            Spacer()
            HStack{
                AppOutlinedCircleButton(size: 30.0, icon: Image(systemName: "plus"), color: Color.gray, source: AppOutlinedCircleButtonContentSource.Icon)
                Text(String(quantity)).font(.title2).frame(width: 40)
                AppOutlinedCircleButton(size: 30.0, icon: Image(systemName: "minus"), color: Color.gray, source: AppOutlinedCircleButtonContentSource.Icon)
            }
        }.padding().cornerRadius(10)
    }
}

struct MemberMemberItemCard_Previews: PreviewProvider {
    static var previews: some View {
        MemberItemCard(name: "Item 1", quantity: 0, onIncrement: {}, onDecrement: {})
    }
}
