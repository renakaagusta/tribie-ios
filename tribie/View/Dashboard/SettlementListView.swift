//
//  SettlementListView.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI

struct SettlementListView: View {
    
    @State var tripId: String
    @State var transactionId: String?
    @ObservedObject var settlementListViewModel : SettlementListViewModel = SettlementListViewModel()
    @State private var showingOptions = false
    @State private var selection = "None"
    @State var showFinish  = false
    @State private var moveToMainView  = false
    
    var body: some View {
        ScrollView {
            VStack {
                if(settlementListViewModel.state == AppState.Loading) {
                    AppLoading()
                }
                if(settlementListViewModel.state == AppState.Empty) {
                    Text("Empty")
                }
                if(settlementListViewModel.state == AppState.Error) {
                    Text("Error")
                }
                if(settlementListViewModel.state == AppState.Exist) {
                    VStack(alignment:.leading){
                        HStack{
                            VStack (alignment:.leading) {
                                AppFootnote(text: "Active Trip", color: Color.footnoteColor, fontWeight: .regular, textAlign: .leading)
                                AppTitle1(text: settlementListViewModel.trip!.title!, color: Color.signifierColor, fontWeight: .semibold,fontSize: 20)
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
                        AppHeader(text: "Settlements", color: Color.primaryColor, textAlign: .leading)
                        AppCaption1(text: "Bills of each member needs to settle one another base on who paid for a transaction")
                    }
                    if(settlementListViewModel.transactionSettlementList != nil && settlementListViewModel.tripMemberList != nil && settlementListViewModel.groupedSettlementList != nil) {
                        VStack {
                            ForEach(settlementListViewModel.groupedSettlementList!) { transactionSettlement in
                                    SettlementCard(userFrom: settlementListViewModel.getUserName(tripMemberId: transactionSettlement.userFromId!),
                                                   userTo: settlementListViewModel.getUserName(tripMemberId: transactionSettlement.userToId!),
                                                amount: transactionSettlement.nominal ?? 0)
                            }
                            if(showFinish == true) {
                                NavigationLink(destination: MainView(tripId: tripId), isActive: $moveToMainView) {
                                    AppElevatedButton(label: "Finish", color: Color.black, backgroundColor: Color.signifierColor, onClick:{
                                        moveToMainView = true
                                    })
                                }
                            }
                        }
                    }
                    if(settlementListViewModel.transactionSettlementList == nil || settlementListViewModel.transactionSettlementList == nil) {
                        AppLoading()
                    }
                    Spacer()
                }
            }
            .padding()
            .background(Color.tertiaryColor)
            .onAppear {
                settlementListViewModel.fetchData(tripId: tripId, transactionId: transactionId)
            }
        }
    }
}

struct SettlementListView_Previews: PreviewProvider {
    static var previews: some View {
        SettlementListView(tripId: "-").preferredColorScheme(scheme)
    }
}
