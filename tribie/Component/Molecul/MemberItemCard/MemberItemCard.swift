//
//  CircleButton.swift
//  macnivision
//
//  Created by renaka agusta on 27/06/22.
//

import SwiftUI

struct MemberItemCard: View {
    @State var name: String
    @Binding var remainingQuantity: Int
    @Binding var quantity: Int
    
    var onIncrement: () -> Void = {}
    var onDecrement: () -> Void = {}
    
    var body: some View {
        HStack {
            HStack {
                AppRadio(selected: false, size: 17.5, color: Color.signifierColor)
                Spacer().frame(width: 10.0)
                VStack(alignment: .leading) {
                    AppBody1(text: "\(name)", color: Color.primaryColor)
                    Spacer().frame(height: 2)
                    HStack {
                        AppCaption1(text: "Remaining", color: Color.footnoteColor)
                        AppCaption1(text: "\(String(remainingQuantity))", color: Color.primaryColor, fontWeight: .bold)
                    }
                }
            }
            Spacer()
            HStack{
                AppOutlinedCircleButton(size: 20.0, icon: Image(systemName: "minus"), color: Color.signifierColor, source: AppOutlinedCircleButtonContentSource.Icon, onClick: {
                    onDecrement()
                })
                Text(String(quantity)).font(.title2).frame(width: 40)
                AppOutlinedCircleButton(size: 20.0, icon: Image(systemName: "plus"), color: Color.signifierColor, source: AppOutlinedCircleButtonContentSource.Icon, onClick: {
                    onIncrement()
                })
            }
        }.padding().cornerRadius(10)
    }
}
