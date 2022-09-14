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
                        VStack(alignment: .leading){
                            HStack{
                                AppFootnote(text: "Active Trip", fontWeight: .regular, textAlign: .leading)
                                    .padding(.horizontal)
                                Spacer()
                            }
                            AppTitle1(text: "Liburan Tribie", color: Color.primaryColor, fontWeight: .semibold, fontSize: 20).padding(.horizontal)
                            Spacer()
                            AppHeader(text: "Drafts", textAlign: .leading)
                            AppCaption1(text: "List of transaction you haven’t manage yet")
                        } //VStack
                        HStack {
                            AppTitle1(text: "Unsplitted Bill", fontWeight: .bold, textAlign: .leading)
                                .padding(.vertical)
                            Spacer()
                        }
                        
                        if(transactionViewModel.transactionList != nil && transactionViewModel.transactionExpensesList != nil) {
                            ForEach(transactionViewModel.transactionList!.filter({$0.status != "Done"})) { transaction in
                                NavigationLink(destination: SplitBillView(tripId: tripId, transactionId: transaction.id!, formState: SplitbillState.InputTransactionItem)) {
                                    RecentTransactionCard(memberPaid: transactionViewModel.getUserPaid(userPaidId: transaction.userPaidId ?? "").name!, title: transaction.title ?? "", date: "24",time: "9.24", total: transaction.grandTotal ?? 0)
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
