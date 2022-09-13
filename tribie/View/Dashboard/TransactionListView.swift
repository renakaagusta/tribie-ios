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
                    VStack(alignment:.leading) {
                        AppFootnote(text: "Active Trip", color: Color.footnoteColor, fontWeight: .regular, textAlign: .leading)
                        AppTitle1(text: "Liburan Tribie", color: Color.primaryColor, fontWeight: .semibold,fontSize: 20)
                        Spacer()
                        HStack{
                            AppHeader(text: "Drafts", color: Color.primaryColor, fontWeight: .bold, textAlign: .leading)
                            Spacer()
                        }
                        AppFootnote(text: "List of transaction you haven’t manage yet", color: Color.footnoteColor, fontWeight: .regular)
                        
                        if(transactionViewModel.transactionList != nil && transactionViewModel.transactionExpensesList != nil) {
                            ForEach(transactionViewModel.transactionList!) { transaction in
                                NavigationLink(destination: SplitBillView(tripId: tripId, transactionId: transaction.id!, formState: SplitbillState.InputTransactionItem)) {
                                    RecentTransactionCard(memberPaid: transactionViewModel.getUserPaid(userPaidId: transaction.userPaidId ?? "").name!, title: transaction.title ?? "", date: "24",time: "9.24", total: transaction.grandTotal ?? 0)
                                }
                            }
                        }
                        if(transactionViewModel.transactionList == nil || transactionViewModel.transactionExpensesList == nil) {
                            AppLoading()
                        }
                    }.padding()
                }
                Spacer()
            }
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
