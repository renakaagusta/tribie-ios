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
        NavigationView {
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
                    
                    if(settlementListViewModel.transactionSettlementList != nil && settlementListViewModel.tripMemberList != nil) {
                        ForEach(settlementListViewModel.transactionSettlementList!) { transactionSettlement in
                            SettlementCard(userFrom: settlementListViewModel.getUserName(tripMemberId: transactionSettlement.userFromId!),
                                           userTo: settlementListViewModel.getUserName(tripMemberId: settlementListViewModel.textLimit(existingText: transactionSettlement.userFromId!, limit: 6)),
                                           
                                           amount: transactionSettlement.nominal ?? 0)
                        }
                    }
                    if(settlementListViewModel.transactionSettlementList == nil || settlementListViewModel.transactionSettlementList == nil) {
                        AppLoading()
                    }
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                AppImageButton(height: 30, width: 30, image: AppImage(height: 24, width: 19, url: "square.and.arrow.up", source: AppImageSource.SystemName, color: Color.primaryColor, component: {}))
            )
            .background(Color.tertiaryColor)
            .padding()
            .onAppear {
                settlementListViewModel.fetchData(tripId: tripId, transactionId: transactionId)
            }
        }
    }
}

struct SettlementListView_Previews: PreviewProvider {
    static var previews: some View {
        SettlementListView().preferredColorScheme(scheme)
    }
}
