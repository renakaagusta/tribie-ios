//
//  TransactionListView.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI

struct TransactionListView: View {

    @State var tripId: String = AppConstant.DUMMY_DATA_TRIP_ID
    @ObservedObject var transactionViewModel: TransactionListViewModel = TransactionListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                AppTitle1(text: "Transactions")
                if (transactionViewModel.state == AppState.Loading) {
                    AppLoading()
                }
                if (transactionViewModel.state == AppState.Empty) {
                    AppBody1(text: "Empty")
                }
                if (transactionViewModel.state == AppState.Error) {
                    AppBody1(text: "Error bang")
                }
                if (transactionViewModel.state == AppState.Exist) {
                    ScrollView {
                        if(transactionViewModel.transactionList != nil && transactionViewModel.transactionExpensesList != nil) {
                            ForEach(transactionViewModel.transactionList!) { transaction in
                                NavigationLink(destination: SplitBillView(tripId: tripId, transactionId: transaction.id!)) {
                                    RecentTransactionCard(memberPaid: transactionViewModel.getTripMemberTransaction(tripId: transaction.tripId ?? ""), title: transaction.title ?? "", date: "s", month: "sa", time: "saa", total: transactionViewModel.getTotalTransactionExpenses(transactionId: transaction.transactionId ?? ""))
                                }
                            }
                        }
                        if(transactionViewModel.transactionList == nil || transactionViewModel.transactionExpensesList == nil) {
                            AppLoading()
                        }
                    }
                }
                Spacer()
            }
            .onAppear {
                transactionViewModel.fetchData(tripId: tripId)
            }
            .navigationTitle("Recent Transactions")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                AppImageButton(height: 30, width: 30, image: AppImage(height: 24, width: 19, url: "square.and.arrow.up.circle", source: AppImageSource.SystemName, color: Color.primary, component: {}))
            )
            .padding()
        }
        
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView().preferredColorScheme(scheme)
    }
}
