//
//  MemberItemListView.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI

struct MemberItemListView: View {
    
    @ObservedObject var memberItemListViewModel : MemberItemListViewModel = MemberItemListViewModel()
    
    var body: some View {
        VStack() {
            if(memberItemListViewModel.state == AppState.Loading) {
                Text("Loading")
            }
            if(memberItemListViewModel.state == AppState.Exist) {
                if(memberItemListViewModel.transactionItemList.count > 0 && memberItemListViewModel.transactionExpenseList.count > 0) {
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
            if(memberItemListViewModel.state == AppState.Error) {
                Text("Error")
            }
        }
    }
}

struct MemberItemListView_Previews: PreviewProvider {
    static var previews: some View {
        MemberItemListView().preferredColorScheme(scheme)
    }
}
