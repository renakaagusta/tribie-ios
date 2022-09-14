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
    @ObservedObject var tripViewModel: TripViewModel = TripViewModel()
    @State private var showingOptions = false
    @State private var selection = "None"
    
    var body: some View {
        ScrollView {
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
                        VStack(alignment: .leading){
                            HStack{
                                VStack (alignment:.leading) {
                                    AppFootnote(text: "Active Trip", color: Color.footnoteColor, fontWeight: .regular, textAlign: .leading)
                                    AppTitle1(text: "Liburan Tribie", color: Color.signifierColor, fontWeight: .semibold,fontSize: 20)
                                }
                                Spacer()
                                
                                AppImageButton(height:22, width:22, image: AppImage(url: "ellipsis.circle", source: AppImageSource.SystemName, color: Color.primaryColor, component: {}), onClick:{
                                    showingOptions = true
                                })
                                .confirmationDialog("", isPresented: $showingOptions, titleVisibility: .automatic) {
                                    
                                    Button("Members") {
                                        selection = "Green"
                                    }
                                    
                                    Button("Share Group Transactions") {
                                        selection = "Blue"
                                    }
                                }
                            }
                            Spacer()
                            AppHeader(text: "Drafts", color: Color.primaryColor, textAlign: .leading)
                            AppCaption1(text: "List of transaction you haven’t manage yet")
                        } //VStack
                        HStack {
                            AppTitle1(text: "Unsplitted Bill",color: Color.primary, fontWeight: .bold, textAlign: .leading)
                                .padding(.vertical)
                            Spacer()
                        }
                        
                        if(transactionViewModel.transactionList != nil && transactionViewModel.transactionExpensesList != nil) {
                            ForEach(transactionViewModel.transactionList!.filter({$0.status != "Done"})) { transaction in
                                NavigationLink(destination: SplitBillView(tripId: tripId, transactionId: transaction.id!, formState: SplitbillState.InputTransactionItem)) {
                                    RecentTransactionCard(memberPaid: transactionViewModel.getUserPaid(userPaidId: transaction.userPaidId ?? "").name!, title: transaction.title ?? "", date: tripViewModel.dateFromString(string: transaction.createdAt ?? ""),time: tripViewModel.timeFromString(string: transaction.createdAt ?? ""), total: transaction.grandTotal ?? 0)
                                }
                            }
                        } else {
                            AppCaption1(text: "You’re done. No unsplitted bill.")
                        }
                        
                        if(transactionViewModel.transactionList == nil || transactionViewModel.transactionExpensesList == nil) {
                            AppLoading()
                        }
                    
                }
                Spacer()
            }.padding()
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
