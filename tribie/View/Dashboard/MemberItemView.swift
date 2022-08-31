//
//  MemberItemListView.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI

struct MemberItemListView: View {
    
    @ObservedObject var memberItemListViewModel : MemberItemListViewModel = MemberItemListViewModel()
    
    @State var tripMemberList : [TripMember]  = [
        TripMember(id: "0", tripId: "", userId: "", name: "Kaka"),
        TripMember(id: "1", tripId: "", userId: "", name: "Arnold"),
        TripMember(id: "2", tripId: "", userId: "", name: "Gusde"),
    ]
    
    @State var transactionExpenseList : [TransactionExpenses]  = [
        TransactionExpenses(id: "0", itemId: "0", tripMemberId: "0", quantity: 1),
        TransactionExpenses(id: "1", itemId: "1", tripMemberId: "1", quantity: 3),
        TransactionExpenses(id: "2", itemId: "2", tripMemberId: "2", quantity: 2),
    ]
    
    var body: some View {
        VStack() {
            AppBody1(text: "Select Member")
            ScrollView(.horizontal) {
                HStack {
                    ForEach(memberItemListViewModel.tripMemberList){
                        tripMember in VStack {
                            MemberAvatarButton(image: AppCircleImage(size: 40.0, component: {}), selected: memberItemListViewModel.selectedUserId == tripMember.id)
                            AppBody1(text: tripMember.name ?? "-")
                        }
                    }
                }
            }.padding()
            AppFootnote(text: "What & how many items did member 1 order?")
            ForEach(memberItemListViewModel.transactionItemList){
                transactionItem in HStack {
                    MemberItemCard(name: transactionItem.title ?? "-", quantity: Int(transactionItem.quantity!), onIncrement: {}, onDecrement: {})
                }
            }
            Spacer()
        }
    }
}

struct MemberItemListView_Previews: PreviewProvider {
    static var previews: some View {
        MemberItemListView().preferredColorScheme(scheme)
    }
}
