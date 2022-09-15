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
            if(memberItemListViewModel.transactionItemList != nil && memberItemListViewModel.transactionExpensesList != nil && memberItemListViewModel.tripMemberList != nil) {
                    ScrollView(.horizontal) {
                            HStack {
                                ForEach(memberItemListViewModel.tripMemberList!){
                                    tripMember in VStack {
                                        MemberAvatarButton(image: AppCircleImage(size: 40.0, component: {}), selected: Binding(get: {memberItemListViewModel.selectedUserId == tripMember.id}, set: { _ in true}), onClick: {
                                            memberItemListViewModel.selectUser(tripMemberId: tripMember.id!)
                                        })
                                        AppBody1(text: tripMember.name ?? "-", color: Color.primaryColor)
                                    }
                                }
                            }
                        }.padding()
                VStack(alignment:.leading){
                    AppFootnote(text: "Assign each members with their items. Choose each item to asign it to a member.", color: Color.footnoteColor)
                }
                        ForEach(memberItemListViewModel.transactionItemList!){
                            transactionItem in HStack {
                                MemberItemCard(name: transactionItem.title ?? "-", remainingQuantity: Binding(get: {memberItemListViewModel.getRemainingQuantity(itemId: transactionItem.id!)}, set: { _ in true }), quantity: Binding(get: {memberItemListViewModel.getItemExpensesQuantity(itemId: transactionItem.id!, tripMemberId: memberItemListViewModel.selectedUserId!)}, set: {_ in true}), onIncrement: {
                                    memberItemListViewModel.handleIncrementQuantity(itemId: transactionItem.id!, tripMemberId: memberItemListViewModel.selectedUserId!)
                                }, onDecrement: {
                                    memberItemListViewModel.handleDecrementQuantity(itemId: transactionItem.id!, tripMemberId:  memberItemListViewModel.selectedUserId!)
                                })
                            }
                        }
                        Spacer()
                    NavigationLink(destination: SplitBillView(tripId: tripId, transactionId: transactionId, formState: SplitbillState.Calculate), isActive: Binding(get: {memberItemListViewModel.moveToSplitBillView == true}, set: { _ in true}) ) {
                        AppElevatedButton(label: "Next", width: UIScreen.width - 70, color: Color.black, backgroundColor: Color.signifierColor, onClick: {
                        memberItemListViewModel.submitTransactionExpenses()
                        memberItemListViewModel.updateTransaction()
                    })
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
