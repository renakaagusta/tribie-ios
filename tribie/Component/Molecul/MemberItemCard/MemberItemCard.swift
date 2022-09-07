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
                AppRadio(selected: false, size: 20, color: Color.gray)
                Spacer().frame(width: 10.0)
                VStack(alignment: .leading) {
                    AppBody1(text: "\(name)")
                    Spacer().frame(height: 2)
                    HStack {
                        AppCaption1(text: "Remaining")
                        AppCaption1(text: "\(String(quantity))", color: Color.primaryColor, fontWeight: .bold)
                    }
                }
            }
            Spacer()
            HStack{
                AppOutlinedCircleButton(size: 20.0, icon: Image(systemName: "plus"), color: Color.gray, source: AppOutlinedCircleButtonContentSource.Icon)
                
                AppBody1(text: "\(String(quantity))", color: Color.primaryColor, fontWeight: .bold).padding(.horizontal)
                
                AppOutlinedCircleButton(size: 20.0, icon: Image(systemName: "minus"), color: Color.gray, source: AppOutlinedCircleButtonContentSource.Icon)
            }
        }.padding().cornerRadius(10)
    }
}

struct MemberMemberItemCard_Previews: PreviewProvider {
    static var previews: some View {
        MemberItemCard(name: "Item 1", quantity: 0, onIncrement: {}, onDecrement: {})
    }
}
