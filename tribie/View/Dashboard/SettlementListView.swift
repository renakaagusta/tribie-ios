//
//  SettlementListView.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import SwiftUI

struct SettlementListView: View {
    
    @State var tripId: String = AppConstant.DUMMY_DATA_TRIP_ID
    @State var transactionId: String?
    @ObservedObject var settlementListViewModel : SettlementListViewModel = SettlementListViewModel()
    
    var body: some View {
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
                    HStack {
                        AppTitle1(text: "Settlements")
                        AppImageButton(image: AppImage(url:"exclamationmark.circle",  source: AppImageSource.SystemName, component: {}))
                    }
                    ScrollView {
                        if(settlementListViewModel.transactionSettlementList != nil && settlementListViewModel.tripMemberList != nil) {
                            ForEach(settlementListViewModel.transactionSettlementList!) { transactionSettlement in
                                SettlementCard(userFrom: settlementListViewModel.getUserName(tripMemberId: transactionSettlement.userFromId!),
                                               userTo: settlementListViewModel.getUserName(tripMemberId: transactionSettlement.userToId!),
                                               amount: transactionSettlement.nominal ?? 0)
                            }
                        }
                        if(settlementListViewModel.transactionSettlementList == nil || settlementListViewModel.transactionSettlementList == nil) {
                            AppLoading()
                        }
                        Spacer()
                    } //Scrollview
                }
            }
            .padding()
            .background(Color.tertiaryColor)
            .onAppear {
                settlementListViewModel.fetchData(tripId: tripId, transactionId: transactionId)
            }
    }
}

struct SettlementListView_Previews: PreviewProvider {
    static var previews: some View {
        SettlementListView().preferredColorScheme(scheme)
    }
}
