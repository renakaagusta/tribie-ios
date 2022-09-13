//
//  TripView.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI


struct TripView: View {
    
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
                            VStack(alignment: .leading){
                                HStack{
                                    AppFootnote(text: "Active Trip", fontWeight: .regular, textAlign: .leading)
                                        .padding(.horizontal)
                                    Spacer()
                                }
                                AppTitle1(text: "Liburan Tribie", fontWeight: .semibold, fontSize: 20).padding(.horizontal)
                                Spacer()
                                AppHeader(text: "Transactions", textAlign: .leading)
                                    .padding(.horizontal)
                            }
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack(spacing:10){
                                    SpendingCard(totalSpending: "\(tripViewModel.calculateTotalExpenses())", startColor: Color.startColor, endColor: Color.endColor)
                                    
                                    DebtsRankCard(startColor: Color.startColor, endColor: Color.endColor, rank1: tripViewModel.tripMemberList![0].name ?? "-", rank2: tripViewModel.tripMemberList![1].name ?? "-", rank3: tripViewModel.tripMemberList![2].name ?? "-", debtsRank1: "\(tripViewModel.tripMemberList![0].expenses ?? 0)", debtsRank2: "\(tripViewModel.tripMemberList![1].expenses ?? 0)", debtsRank3: "\(tripViewModel.tripMemberList![2].expenses ?? 0)")
                                }
                            }
                            HStack{
                                VStack(alignment: .leading) {
                                    AppTitle1(text: "Recent Transactions", color: Color.primaryColor, fontWeight: .semibold, fontSize: 22)                                }
                                Spacer()
                                NavigationLink(destination: SplitBillView(tripId: tripId, formState: SplitbillState.InputTransaction)) {
                                    AppImage(height: 22, width: 22, url: "plus.circle.fill", source: AppImageSource.SystemName, color: Color.primaryColor, component: {})
                                }
                            }
                            .padding(.horizontal)
                            VStack {
                                if(tripViewModel.transactionList != nil && tripViewModel.tripMemberList != nil) {
                                    ForEach(tripViewModel.transactionList!) {
                                        transaction in NavigationLink(destination: SplitBillView(tripId: tripId, transactionId: transaction.id!, formState:getSplitBillState(status: transaction.status!))) {
                                            RecentTransactionCard(memberPaid: tripViewModel.getUserPaid(userPaidId: transaction.userPaidId ?? "").name!, title: transaction.title ?? "", date: tripViewModel.dateFromString(string: transaction.createdAt ?? ""), time: tripViewModel.timeFromString(string: transaction.createdAt ?? ""), total: transaction.grandTotal ?? 0)
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
                        VStack {
                            VStack(alignment: .leading){
                                HStack{
                                    AppFootnote(text: "Active Trip", fontWeight: .regular, textAlign: .leading)
                                        .padding(.horizontal)
                                    Spacer()
                                }
                                AppTitle1(text: "Liburan Tribie", color: Color.primaryColor, fontWeight: .semibold, fontSize: 20).padding(.horizontal)
                                Spacer()
                                AppHeader(text: "Transactions", textAlign: .leading)
                                    .padding(.horizontal)
                            }
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack(spacing:10){
                                    //                                        SpendingCard(totalSpending: "0", startColor: Color.startColor, endColor: Color.endColor)
                                    //
                                    //                                        DebtsRankCard(startColor: Color.startColor, endColor: Color.endColor, rank1: tripViewModel.tripMemberList![0].name ?? "-", rank2: tripViewModel.tripMemberList![1].name ?? "-", rank3: tripViewModel.tripMemberList![2].name ?? "-", debtsRank1: "\(tripViewModel.tripMemberList![0].expenses ?? 0)", debtsRank2: "\(tripViewModel.tripMemberList![1].expenses ?? 0)", debtsRank3: "\(tripViewModel.tripMemberList![2].expenses ?? 0)")
                                }
                            }
                            HStack{
                                VStack(alignment: .leading) {
                                    AppTitle1(text: "Recent Transactions", color: Color.primaryColor, fontWeight: .semibold, fontSize: 22)                                }
                                Spacer()
                                NavigationLink(destination: SplitBillView(tripId: tripId, formState: SplitbillState.InputTransaction)) {
                                    AppImage(height: 22, width: 22, url: "plus.circle.fill", source: AppImageSource.SystemName, color: Color.primaryColor, component: {})
                                }
                            }
                            .padding(.horizontal)
                            VStack {
                                if(tripViewModel.transactionList != nil && tripViewModel.tripMemberList != nil) {
                                    List {
                                        ForEach(tripViewModel.transactionList!, id: \.self) {
                                            transaction in NavigationLink(destination: SplitBillView(tripId: tripId, transactionId: transaction.id!, formState: SplitbillState.InputTransactionItem)) {
                                                RecentTransactionCard(memberPaid: tripViewModel.getUserPaid(userPaidId: transaction.userPaidId ?? "").name!, title: transaction.title ?? "", date: tripViewModel.dateFromString(string: transaction.createdAt ?? ""), time: tripViewModel.timeFromString(string: transaction.createdAt ?? ""), total: transaction.grandTotal ?? 0).padding(.horizontal)
                                            }
                                        }.onDelete(perform: removeCards)
                                    }
                                }
                                if(tripViewModel.transactionList == nil || tripViewModel.tripMemberList == nil) {
                                    AppLoading()
                                }
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
    
    //function
    func removeCards(at offsets: IndexSet) {
        self.tripViewModel.transactionList!.remove(atOffsets: offsets)
        //tripViewModel.transactionList?.remove(atOffsets: offsets)
    }
    
    struct TripView_Previews: PreviewProvider {
        static var previews: some View {
            TripView().preferredColorScheme(scheme)
        }
    }
}
