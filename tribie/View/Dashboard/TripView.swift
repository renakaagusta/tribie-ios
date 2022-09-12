//
//  TripView.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI


struct TripView: View {
    
    //variable for modal view
    @State var showGroupTripModalView: Bool = false
    
    //variable
    @State private var showingOptions = false
    @State private var selection = "None"
    @State var tripId: String = AppConstant.DUMMY_DATA_TRIP_ID
    @ObservedObject var tripViewModel = TripViewModel()
    
    func getSplitBillState(status: String) -> SplitbillState {
        if(status == "Item") {
            return SplitbillState.InputTransactionItem
        } else if(status == "Expenses") {
            return SplitbillState.Done
        } else if(status == "Calculated") {
            return SplitbillState.Calculate
        }
        return SplitbillState.InputTransactionItem
    }
    
    var body: some View {
        VStack{
            if(tripViewModel.state == AppState.Loading){
                AppLoading()
            }
            if(tripViewModel.state == AppState.Exist){
                if(tripViewModel.tripMemberList != nil && tripViewModel.transactionList != nil && tripViewModel.transactionItemList != nil && tripViewModel.transactionExpensesList != nil && tripViewModel.transactionSettlementList != nil){
                    ScrollView {
                        VStack {
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack(spacing:10){
                                    AppCard(width: 350, height: 150, cornerRadius: 20, backgroundColor: Color.white, component: {
                                        AppTitle1(text: "Total Spending", fontWeight: .regular, fontSize: 22)
                                        
                                        AppFootnote(text: "on this trip", color: Color.primaryColor, fontWeight: .regular)
                                        
                                        AppHeader(text: String(tripViewModel.calculateTotalExpenses()), color: Color.primaryColor, fontWeight: .bold)
                                            .padding(1)
                                    }).padding(.vertical)
                                    
                                    AppCard(width: 350, height: 150, cornerRadius: 20, backgroundColor: Color.white, component: {
                                        AppTitle1(text: "Debts Rank", fontWeight: .semibold, fontSize: 22)
                                        AppFootnote(text: "Top 1 in debt better pay the next bill", color: Color.primaryColor, fontWeight: .regular, textAlign: .center)
                                        VStack(alignment: .leading){
                                            HStack{
                                                AppTitle1(text: "Member 1", color: Color.gray, fontWeight: .bold, fontSize: 23).padding(.horizontal)
                                                Spacer()
                                                AppTitle1(text: "Rp0", color: Color.primaryColor, fontWeight: .bold, fontSize: 22).padding(.horizontal)
                                            }
                                            
                                            HStack{
                                                AppTitle1(text: "Member 2", color: Color.gray, fontWeight: .regular, fontSize: 16).padding(.horizontal)
                                                Spacer()
                                                AppTitle1(text: "Rp0", color: Color.primaryColor, fontWeight: .semibold, fontSize: 16).padding(.horizontal)
                                            }
                                            
                                            HStack{
                                                AppTitle1(text: "Member 3", color: Color.gray, fontWeight: .regular, fontSize: 13).padding(.horizontal)
                                                Spacer()
                                                AppTitle1(text: "Rp0", color: Color.primaryColor, fontWeight: .semibold, fontSize: 13).padding(.horizontal)
                                            }
                                        }
                                    })
                                }
                            }
                            
                            Button(action: {
                                showGroupTripModalView = true
                            }, label: {
                                Text("Modal View")
                            })
                            .sheet(isPresented: $showGroupTripModalView) {
                                GroupTripView()
                            }
                            
                            HStack{
                                VStack(alignment: .leading) {
                                    AppTitle1(text: "Recent Transactions", color: Color.primaryColor, fontWeight: .semibold, fontSize: 22)                                }
                                Spacer()
                                NavigationLink(destination: SplitBillView(tripId: tripId, formState: SplitbillState.InputTransaction)) {
                                                                    AppImage(height: 22, width: 22, url: "plus.circle.fill", source: AppImageSource.SystemName, color: Color.primaryColor, component: {})
                                                                }
//                                NavigationLink(destination: SplitBillView(tripId: tripId, transactionId: nil, formState: SplitbillState.InputTransaction)) {
//                                    AppImage(height: 22, width: 22, url: "plus.circle.fill", source: AppImageSource.SystemName, color: Color.primaryColor, component: {})
//                                }
                            }
                            .padding(.horizontal)
                            VStack {
                                if(tripViewModel.transactionList != nil && tripViewModel.tripMemberList != nil) {
                                    ForEach(tripViewModel.transactionList!) {
                                        transaction in NavigationLink(destination: SplitBillView(tripId: tripId, transactionId: transaction.id!, formState: SplitbillState.InputTransactionItem)) {
                                            RecentTransactionCard(memberPaid: tripViewModel.getUserPaid(userPaidId: transaction.userPaidId ?? "").name!, title: transaction.title ?? "", date: "24", month: "August", time: "9.24", total: transaction.grandTotal ?? 0)
                                                .padding(.horizontal)
                                        }
                                    }
                                }
                                if(tripViewModel.transactionList == nil || tripViewModel.tripMemberList == nil) {
                                    AppLoading()
                                }
                            }
                        }
                        .navigationBarItems(trailing: AppImageButton(height:22, width:22, image: AppImage(url: "ellipsis.circle", source: AppImageSource.SystemName, color: Color.primaryColor, component: {}), onClick:{
                            showingOptions = true
                        })
                            .confirmationDialog("", isPresented: $showingOptions, titleVisibility: .automatic) {
                                
                                Button("Members") {
                                    selection = "Green"
                                }
                                
                                Button("Share Group Transactions") {
                                    selection = "Blue"
                                }
                            })
                    }
                }
            }
            if(tripViewModel.state == AppState.Empty){
                ScrollView {
                    VStack {
                        ScrollView(.horizontal,showsIndicators: false){
                            HStack(spacing:10){
                                AppCard(width: 350, height: 150, cornerRadius: 20, backgroundColor: Color.white, component: {
                                    AppTitle1(text: "Total Spending", fontWeight: .regular, fontSize: 22)
                                    
                                    AppFootnote(text: "on this trip", color: Color.primaryColor, fontWeight: .regular)
                                    
                                    AppHeader(text: String(tripViewModel.calculateTotalExpenses()), color: Color.primaryColor, fontWeight: .bold)
                                        .padding(1)
                                }).padding(.vertical)
                                
                                AppCard(width: 350, height: 150, cornerRadius: 20, backgroundColor: Color.white, component: {
                                    AppTitle1(text: "Debts Rank", fontWeight: .semibold, fontSize: 22)
                                    AppFootnote(text: "Top 1 in debt better pay the next bill", color: Color.primaryColor, fontWeight: .regular, textAlign: .center)
                                    VStack(alignment: .leading){
                                        HStack{
                                            AppTitle1(text: "Member 1", color: Color.gray, fontWeight: .bold, fontSize: 23).padding(.horizontal)
                                            Spacer()
                                            AppTitle1(text: "Rp0", color: Color.primaryColor, fontWeight: .bold, fontSize: 22).padding(.horizontal)
                                        }
                                        
                                        HStack{
                                            AppTitle1(text: "Member 2", color: Color.gray, fontWeight: .regular, fontSize: 16).padding(.horizontal)
                                            Spacer()
                                            AppTitle1(text: "Rp0", color: Color.primaryColor, fontWeight: .semibold, fontSize: 16).padding(.horizontal)
                                        }
                                        
                                        HStack{
                                            AppTitle1(text: "Member 3", color: Color.gray, fontWeight: .regular, fontSize: 13).padding(.horizontal)
                                            Spacer()
                                            AppTitle1(text: "Rp0", color: Color.primaryColor, fontWeight: .semibold, fontSize: 13).padding(.horizontal)
                                        }
                                    }
                                })
                            }
                        }
                        
                        HStack{
                            
                            VStack(alignment: .leading) {
                                Text("Recent Transactions")
                            }
                            Spacer()
                            AppImageButton(height: 22, width: 22, image: AppImage(height: 22, width: 22, url: "plus.circle.fill", source: AppImageSource.SystemName, color: Color.primaryColor, component: {}))
                        }
                        .padding(.horizontal)
                        AppFootnote(text: "No transactions. Go add a new transaction to this group.")
                            .padding(.horizontal)
                        
                        Spacer()
                    }
                    .navigationBarItems(trailing: AppImageButton(height:22, width:22, image: AppImage(url: "ellipsis.circle", source: AppImageSource.SystemName, color: Color.primaryColor, component: {}), onClick: {
                        showingOptions = true
                    })
                        .confirmationDialog("", isPresented: $showingOptions, titleVisibility: .automatic) {
                            
                            Button("Members") {
                                selection = "Green"
                            }
                            
                            Button("Share Group Transactions") {
                                selection = "Blue"
                            }
                        })
                }
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
    
    //delete transaction
//    func deleteTransactions(at offsets: IndexSet) {
//        tripViewModel.transactionList?.remove(atOffsets: offsets)
//    }
    
    struct TripView_Previews: PreviewProvider {
        static var previews: some View {
            TripView().preferredColorScheme(scheme)
        }
    }
}
