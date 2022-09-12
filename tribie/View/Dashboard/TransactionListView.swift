//
//  TransactionListView.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI
import SwiftyBeaver

struct TransactionListView: View {

    @State var tripId: String = AppConstant.DUMMY_DATA_TRIP_ID
    @ObservedObject var transactionViewModel: TransactionListViewModel = TransactionListViewModel()
    
    var body: some View {
            VStack {
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
                        HStack {
                            AppTitle1(text: "Drafts")
                            AppImageButton(image: AppImage(height: 30, width: 30, url: "exclamationmark.circle", source: AppImageSource.SystemName, color: Color.gray, component: {}))
                        }
                        AppCaption1(text: "List of transaction you haven’t manage yet")
                        AppBody1(text: "Unsplitted Bill", fontWeight: .bold, textAlign: .leading).padding()
                        if(transactionViewModel.transactionList != nil && transactionViewModel.transactionExpensesList != nil) {
                            ForEach(transactionViewModel.transactionList!) { transaction in
                                NavigationLink(destination: SplitBillView(tripId: tripId, transactionId: transaction.id!, formState: SplitbillState.InputTransactionItem)) {
                                    RecentTransactionCard(memberPaid: transactionViewModel.getUserPaid(userPaidId: transaction.userPaidId ?? "").name!, title: transaction.title ?? "", date: "24", month: "August", time: "9.24", total: transaction.grandTotal ?? 0)
                                       .padding(.horizontal)
                                }
                            }
                        } else {
                            AppCaption1(text: "You’re done. No unsplitted bill.")
                        }
                        
                        if(transactionViewModel.transactionList == nil || transactionViewModel.transactionExpensesList == nil) {
                            AppLoading()
                        }
                    }.padding()
                }
                Spacer()
            }
            .onAppear {
                transactionViewModel.fetchData(tripId: tripId)
            }
            .background(Color.tertiaryColor)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                AppImageButton(height: 30, width: 30, image: AppImage(height: 24, width: 19, url: "square.and.arrow.up", source: AppImageSource.SystemName, color: Color.primaryColor, component: {}))
            )
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView().preferredColorScheme(scheme)
    }
}
