//
//  MemberItemListView.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI

struct MemberItemListView: View {
    
    @State var tripId: String = AppConstant.DUMMY_DATA_TRIP_ID
    @State var transactionId: String = AppConstant.DUMMY_DATA_TRANSACTION_ID
    @ObservedObject var memberItemListViewModel : MemberItemListViewModel = MemberItemListViewModel()
    
    var body: some View {
        VStack() {
            if(memberItemListViewModel.state == AppState.Loading) {
                AppLoading()
            }
            if(memberItemListViewModel.state == AppState.Exist) {
                if(memberItemListViewModel.transactionItemList != nil && memberItemListViewModel.transactionExpensesList != nil) {
                        AppBody1(text: "Select Member")
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(memberItemListViewModel.tripMemberList!){
                                    tripMember in VStack {
                                        MemberAvatarButton(image: AppCircleImage(size: 40.0, component: {}), selected: memberItemListViewModel.selectedUserId == tripMember.id, onClick: {
                                            memberItemListViewModel.selectUser(tripMemberId: tripMember.id!)
                                        })
                                        AppBody1(text: tripMember.name ?? "-")
                                    }
                                }
                            }
                        }.padding()
                        AppFootnote(text: "What & how many items did member 1 order?")
                        ForEach(memberItemListViewModel.transactionItemList!){
                            transactionItem in HStack {
                                MemberItemCard(name: transactionItem.title ?? "-", quantity: memberItemListViewModel.getItemExpensesQuantity(itemId: transactionItem.id!, tripMemberId: memberItemListViewModel.selectedUserId!), onIncrement: {
                                    memberItemListViewModel.handleIncrementQuantity(itemId: transactionItem.id!, tripMemberId: memberItemListViewModel.selectedUserId!)
                                }, onDecrement: {
                                    memberItemListViewModel.handleIncrementQuantity(itemId: transactionItem.id!, tripMemberId: memberItemListViewModel.selectedUserId!)
                                })
                            }
                        }
                        Spacer()
                }
                if(memberItemListViewModel.transactionItemList == nil || memberItemListViewModel.transactionExpensesList == nil) {
                    
                }
            }
            if(memberItemListViewModel.state == AppState.Error) {
                Text("Error")
            }
        }.onAppear {
            memberItemListViewModel.fetchData(tripId: tripId, transactionId: transactionId)
        }
    }
}

struct MemberItemListView_Previews: PreviewProvider {
    static var previews: some View {
        MemberItemListView().preferredColorScheme(scheme)
    }
}
