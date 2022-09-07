//
//  TripView.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI


struct TripView: View {
    
    @State var tripId: String = AppConstant.DUMMY_DATA_TRIP_ID
    @ObservedObject var tripViewModel = TripViewModel()
    
    var body: some View {
            VStack{
                if(tripViewModel.state == AppState.Loading){
                    AppLoading()
                }
                if(tripViewModel.state == AppState.Exist){
                    if(tripViewModel.tripMemberList != nil && tripViewModel.transactionList != nil && tripViewModel.transactionItemList != nil && tripViewModel.transactionExpensesList != nil && tripViewModel.transactionSettlementList != nil){
                            ScrollView {
                                VStack {
                                    HStack{
                                        VStack(alignment: .leading) {
                                            Text("Recent Transactions")
                                        }
                                        AppImageButton(height: 22, width: 22, image: AppImage(url: "exclamationmark.circle", source: AppImageSource.SystemName, component: {}))
                                        Spacer()
                                        NavigationLink(destination: SplitBillView(tripId: tripId, formState: SplitbillState.InputTransaction)) {
                                            AppImage(height: 22, width: 22, url: "plus.circle.fill", source: AppImageSource.SystemName, component: {})
                                        }
                                    }
                                    .padding(.horizontal)
                                    VStack {
                                        if(tripViewModel.transactionList != nil && tripViewModel.tripMemberList != nil) {
                                            ForEach(tripViewModel.transactionList!) {
                                                transaction in NavigationLink(destination: SplitBillView(tripId: tripId, transactionId: transaction.id!, formState: SplitbillState.InputTransactionItem)) {
                                                    RecentTransactionCard(memberPaid: tripViewModel.getUserPaid(userPaidId: transaction.userPaidId ?? "").name!, title: transaction.title ?? "", date: "24", month: "August", time: "9.24", total: tripViewModel.calculateTotalExpensesPerTransaction(transactionId: transaction.id!))
                                                        .padding(.horizontal)
                                                }
                                            }
                                        }
                                        if(tripViewModel.transactionList == nil || tripViewModel.tripMemberList == nil) {
                                            AppLoading()
                                        }
                                    }
                                    NavigationLink(destination: TransactionListView(tripId: tripId)){
                                        HStack {
                                            AppLink(label: "See all").padding(.horizontal)
                                        }
                                    }
                                    Spacer()
                                    HStack{
                                        VStack(alignment: .leading) {
                                            Text("Settlements")
                                        }
                                        AppImageButton(height: 22, width: 22, image: AppImage(url: "exclamationmark.circle", source: AppImageSource.SystemName, component: {}))
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                    VStack {
                                        if(tripViewModel.transactionSettlementList != nil && tripViewModel.tripMemberList != nil) {
                                            ForEach(tripViewModel.transactionSettlementList!) {
                                                settlement in NavigationLink(destination: SplitBillView()) {
                                                    SettlementCard(userFrom: tripViewModel.getUserName(tripMemberId: settlement.userFromId!), userTo: tripViewModel.getUserName(tripMemberId: settlement.userToId!), amount: settlement.nominal ?? 0)
                                                        .padding(.horizontal)
                                                }
                                            }
                                        }
                                        if(tripViewModel.transactionSettlementList == nil || tripViewModel.tripMemberList == nil) {
                                            AppLoading()
                                        }
                                    }
                                    NavigationLink(destination: SettlementListView(tripId: tripId)){
                                        AppLink(label: "See all").padding(.horizontal)
                                    }
                                    Spacer()
                                }
                                .navigationBarItems(trailing: AppImageButton(height:19, width:24, image: AppImage(url: "square.and.arrow.up", source: AppImageSource.SystemName, component: {})))
                            }
                        }
                }
                if(tripViewModel.state == AppState.Empty){
                        VStack {
                            HStack{
                                VStack(alignment: .leading) {
                                    Text("Recent Transactions")
                                }
                                AppImageButton(height: 22, width: 22, image: AppImage(url: "exclamationmark.circle", source: AppImageSource.SystemName, component: {}))
                                Spacer()
                                AppImageButton(height: 22, width: 22, image: AppImage(height: 22, width: 22, url: "plus.circle.fill", source: AppImageSource.SystemName, component: {}))
                            }
                            .padding(.horizontal)
                            AppFootnote(text: "No transactions. Go add a new transaction to this group.")
                                .padding(.horizontal)
                            Spacer()
                            HStack{
                                VStack(alignment: .leading) {
                                    Text("Settlements")
                                }
                                AppImageButton(height: 22, width: 22, image: AppImage(url: "exclamationmark.circle", source: AppImageSource.SystemName, component: {}))
                                Spacer()
                            }
                            .padding(.horizontal)
                            AppFootnote(text: "No settlements. Go add a new transaction to settle with your freinds.")
                                .padding(.horizontal)
                            Spacer()
                        }
                        .navigationBarItems(trailing: AppImageButton(height:19, width:24, image: AppImage(url: "square.and.arrow.up", source: AppImageSource.SystemName, component: {})))
                    }
                if(tripViewModel.state == AppState.Error){
                    AppBody1(text:"Error")
                }
        }
        .background(Color.tertiaryColor)
        .onAppear {
            tripViewModel.fetchData(tripId: tripId)
        }
    }
    
    struct TripView_Previews: PreviewProvider {
        static var previews: some View {
            TripView().preferredColorScheme(scheme)
        }
    }
}
