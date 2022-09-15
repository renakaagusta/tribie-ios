//
//  TripView.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI
import UIKit

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
        ScrollView {
            VStack {
                if(tripViewModel.state == AppState.Loading){
                    AppLoading()
                }
                if(tripViewModel.state == AppState.Exist){
                    if(tripViewModel.tripMemberList != nil && tripViewModel.transactionList != nil && tripViewModel.transactionItemList != nil && tripViewModel.transactionExpensesList != nil && tripViewModel.transactionSettlementList != nil){
                                VStack(alignment: .leading){
                                    HStack{
                                        VStack (alignment:.leading) {
                                            AppFootnote(text: "Active Trip", color: Color.footnoteColor, fontWeight: .regular, textAlign: .leading)
                                                .padding(.horizontal)
                                            AppTitle1(text: "Liburan Tribie", color: Color.signifierColor, fontWeight: .semibold,fontSize: 20).padding(.horizontal)
                                        }
                                        Spacer()
                                        
                                        AppImageButton(height:22, width:22, image: AppImage(url: "ellipsis.circle", source: AppImageSource.SystemName, color: Color.primaryColor, component: {}), onClick:{
                                            showingOptions = true
                                        })
                                        .confirmationDialog("", isPresented: $showingOptions, titleVisibility: .automatic) {
                                            
                                            Button("Members") {
                                                selection = "Green"
                                            }
                                            
                                            Button("Share Group Transactions", action: {
                                                tripViewModel.exportReport()
                                            })
                                        }
                                        
                                    }
                                    
                                    Spacer()
                                    AppHeader(text: "Transactions", color: Color.primaryColor, textAlign: .leading)
                                        .padding(.horizontal)
                                    AppFootnote(text: "Summary of all transactions you’ve added to this trip", color: Color.footnoteColor, fontWeight: .regular, textAlign: .leading)
                                        .padding(.horizontal)
                                }
                                ScrollView(.horizontal,showsIndicators: false){
                                    HStack(spacing:10){
                                        SpendingCard(totalSpending: (tripViewModel.calculateTotalExpenses()), startColor: Color.startColor, endColor: Color.endColor)
                                        
                                        DebtsRankCard(startColor: Color.startColor, endColor: Color.endColor, rank1: tripViewModel.tripMemberList![0].name ?? "-", rank2: tripViewModel.tripMemberList![1].name ?? "-", rank3: tripViewModel.tripMemberList![2].name ?? "-", debtsRank1: "\(tripViewModel.tripMemberList![0].expenses ?? 0)", debtsRank2: "\(tripViewModel.tripMemberList![1].expenses ?? 0)", debtsRank3: "\(tripViewModel.tripMemberList![2].expenses ?? 0)")
                                    }
                                }
                                HStack{
                                    VStack(alignment: .leading) {
                                        AppTitle1(text: "Recent Transactions", color: Color.primaryColor, fontWeight: .semibold, fontSize: 22)                                }
                                    Spacer()
                                    NavigationLink(destination: SplitBillView(tripId: tripId, formState: SplitbillState.InputTransaction)) {
                                        AppImage(height: 22, width: 22, url: "plus.circle.fill", source: AppImageSource.SystemName, color: Color.signifierColor, component: {})
                                    }
                                }
                                .padding(.horizontal)
                                VStack {
                                    if(tripViewModel.transactionList != nil && tripViewModel.tripMemberList != nil) {
                                        ForEach(tripViewModel.transactionList!.filter({$0.status == "Done"})) {
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
                }
                if(tripViewModel.state == AppState.Empty){
                        VStack {
                            VStack {
                                VStack(alignment: .leading){
                                    HStack{
                                        AppFootnote(text: "Active Trip", color: Color.footnoteColor, fontWeight: .regular, textAlign: .leading)
                                            .padding(.horizontal)
                                        Spacer()
                                    }
                                    AppTitle1(text: "Liburan Tribie", color: Color.primaryColor, fontWeight: .semibold, fontSize: 20).padding(.horizontal)
                                    Spacer()
                                    AppHeader(text: "Transactions", color: Color.primaryColor, textAlign: .leading)
                                        .padding(.horizontal)
                                    AppFootnote(text: "Summary of all transactions you’ve added to this trip", color: Color.footnoteColor, fontWeight: .regular, textAlign: .leading)
                                        .padding(.horizontal)
                                }
                                ScrollView(.horizontal,showsIndicators: false){
                                    HStack(spacing:10){
                                        SpendingCard(totalSpending: 0, startColor: Color.startColor, endColor: Color.endColor)
                                        
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
                        
                }
                if(tripViewModel.state == AppState.Error){
                    AppBody1(text:"Error")
                }
            }.sheet(isPresented: Binding(get: {tripViewModel.showReport ?? false}, set: {_ in true})) {
                ShareSheet(activityItems: [Binding(get: {tripViewModel.reportText ?? "-"}, set: {_ in true}).wrappedValue])
            }
            .background(Color.tertiaryColor)
            .onAppear {
                tripViewModel.fetchData(tripId: tripId)
            }
            
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

struct ShareSheet: UIViewControllerRepresentable {
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
    
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    let callback: Callback? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing to do here
    }
}
