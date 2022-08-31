//
//  TripView.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI


struct TripView: View {
    
    @ObservedObject var tripViewModel = TripViewModel()
    
    func calculateTotalExpenses() -> Int {
        var totalExpenses: Int = 0
        
        for transactionExpenses in tripViewModel.transactionExpensesList {
            totalExpenses += transactionExpenses.quantity! * tripViewModel.transactionItemList.first(where: { $0.id == transactionExpenses.itemId})!.price!
        }
        return totalExpenses
    }
    
    func calculateTotalExpensesPerTransaction(transactionId: String) -> Int {
        var totalExpensesPerTransaction: Int = 0
        
        for transactionExpenses in tripViewModel.transactionExpensesList {
            if(transactionExpenses.transactionId == transactionId){
                totalExpensesPerTransaction += transactionExpenses.quantity! * tripViewModel.transactionItemList.first(where: { $0.id == transactionExpenses.itemId})!.price!
            }
            return totalExpensesPerTransaction
        }
        
        return totalExpensesPerTransaction
    }
    
    func getUserPaid(userPaidId: String) -> TripMember {
        
        return tripViewModel.tripMemberList[0]
    }
    
    var body: some View {
        VStack{
            if(tripViewModel.state == AppState.Loading){
                AppBody1(text:"Loading")
            }
            
            if(tripViewModel.state == AppState.Exist){
                //                ForEach(tripViewModel.tripMemberList) {
                //                    tripMember in HStack {
                //                        Text(getMemberExpenses(tripMemberId: tripMember.id))
                //                    }
                //                }
                NavigationView{
                    ScrollView {
                        VStack {
                            SpendingCard(totalSpending: calculateTotalExpenses())
                            HStack{
                                VStack(alignment: .leading) {
                                    Text("Recent Transactions")
                                }
                                AppImageButton(height: 22, width: 22, image: AppImage(url: "exclamationmark.circle", source: AppImageSource.SystemName, component: {}))
                                Spacer()
                                AppImageButton(height: 22, width: 22, image: AppImage(height: 22, width: 22, url: "plus.circle.fill", source: AppImageSource.SystemName, component: {}))
                            }
                            .padding(.horizontal)
                            
                            ForEach(tripViewModel.transactionList) {
                                transaction in RecentTransactionCard(memberPaid: getUserPaid(userPaidId: transaction.userPaidId ?? "").name!, title: transaction.title ?? "", date: "24", month: "August", time: "9.24", total: calculateTotalExpensesPerTransaction(transactionId: "0"))
                                    .padding(.horizontal)
                            }
                            
                            AppLinkButton(label: "See all")
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
                            
                            SettlementCard(userFrom: "Arnold", userTo: "Kaka", amount: 20000)
                                .padding(.horizontal)
                            
                            AppLinkButton(label: "See all")
                                .padding(.horizontal)
                            
                            Spacer()
                        }
                        .navigationBarItems(trailing: AppImageButton(height:19, width:24, image: AppImage(url: "square.and.arrow.up", source: AppImageSource.SystemName, component: {})))
                    }
                }
            }
            
            if(tripViewModel.state == AppState.Empty){
                NavigationView{
                    VStack {
                        SpendingCard(totalSpending: 70000)
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
            }
            
            if(tripViewModel.state == AppState.Error){
                AppBody1(text:"Error")
            }
        }.onAppear {
            tripViewModel.fetchData()
        }
    }
    
    struct TripView_Previews: PreviewProvider {
        static var previews: some View {
            TripView().preferredColorScheme(scheme)
        }
    }
}
