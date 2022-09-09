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
                AppRadio(selected: false, size: 20, color: Color.gray)
                Spacer().frame(width: 10.0)
                VStack(alignment: .leading) {
                    AppBody1(text: "\(name)")
                    Spacer().frame(height: 2)
                    HStack {
                        AppCaption1(text: "Remaining")
                        AppCaption1(text: "\(String(remainingQuantity))", color: Color.primaryColor, fontWeight: .bold)
                    }
                }
            }
            Spacer()
            HStack{
                AppOutlinedCircleButton(size: 30.0, icon: Image(systemName: "minus"), color: Color.gray, source: AppOutlinedCircleButtonContentSource.Icon, onClick: {
                    onDecrement()
                })
                Text(String(quantity)).font(.title2).frame(width: 40)
                AppOutlinedCircleButton(size: 30.0, icon: Image(systemName: "plus"), color: Color.gray, source: AppOutlinedCircleButtonContentSource.Icon, onClick: {
                    onIncrement()
                })
            }
        }.padding().cornerRadius(10)
    }
}
