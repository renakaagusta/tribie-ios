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
                                        transaction in NavigationLink(destination: SplitBillView(tripId: tripId, transactionId: transaction.id!, formState: SplitbillState.InputTransactionItem)) {
                                            RecentTransactionCard(memberPaid: tripViewModel.getUserPaid(userPaidId: transaction.userPaidId ?? "").name!, title: transaction.title ?? "", date: tripViewModel.dateFromString(string: transaction.createdAt ?? ""), time: tripViewModel.timeFromString(string: transaction.createdAt ?? ""), total: tripViewModel.calculateTotalExpensesPerTransaction(transactionId: transaction.id!))
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
                                AppTitle1(text: "Liburan Tribie", fontWeight: .semibold, fontSize: 20).padding(.horizontal)
                                Spacer()
                                AppHeader(text: "Transactions", textAlign: .leading)
                                    .padding(.horizontal)
                            }
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
                                        transaction in NavigationLink(destination: SplitBillView(tripId: tripId, transactionId: transaction.id!, formState: SplitbillState.InputTransactionItem)) {
                                            RecentTransactionCard(memberPaid: tripViewModel.getUserPaid(userPaidId: transaction.userPaidId ?? "").name!, title: transaction.title ?? "", date: tripViewModel.dateFromString(string: transaction.createdAt ?? ""), time: tripViewModel.timeFromString(string: transaction.createdAt ?? ""), total: tripViewModel.calculateTotalExpensesPerTransaction(transactionId: transaction.id!))
                                                .padding(.horizontal)
                                        }
                                    }
                                }
                                if(tripViewModel.transactionList == nil || tripViewModel.tripMemberList == nil) {
                                    AppLoading()
                                }
                            }
                        }
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
    
    struct TripView_Previews: PreviewProvider {
        static var previews: some View {
            TripView().preferredColorScheme(scheme)
        }
    }
}
