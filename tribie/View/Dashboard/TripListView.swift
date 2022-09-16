//
//  TripListView.swift
//  tribie
//
//  Created by renaka agusta on 03/09/22.
//

import SwiftUI

struct TripListView: View {
    
    @State var showGroupMember: Bool = false
    @State var showProfile: Bool = false

    @ObservedObject var tripListViewModel: TripListViewModel = TripListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if (tripListViewModel.state == AppState.Loading) {
                    AppLoading()
                }
                if (tripListViewModel.state == AppState.Empty) {
                    AppBody1(text: "Empty")
                }
                if (tripListViewModel.state == AppState.Error) {
                    AppBody1(text: "Error")
                }
                if (tripListViewModel.state == AppState.Exist) {
                    if(tripListViewModel.filteredTripList != nil && tripListViewModel.transactionList != nil) {
                            Spacer().frame(height: 10)
                                    ForEach(tripListViewModel.filteredTripList!) { trip in
                                        NavigationLink(destination: MainView(tripId: trip.id!)){
                                            TripListCard(title: trip.title ?? "-", members: tripListViewModel.getTripMemberNameList(tripId: trip.id!), amount: tripListViewModel.getTotalTripSpending(tripId: trip.id!))
                                        }
                                    }
                                }
                    if(tripListViewModel.filteredTripList == nil) {
                            AppLoading()
                        }
                    }
                Spacer()
            }
            .background(Color.tertiaryColor)
            .onAppear {
                Logger.debug("should be refresh1")
                tripListViewModel.fetchData()
            }.navigationTitle("Trips")
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            showProfile = true
                        }, label: {
                            AppImage(url: "person.crop.circle", source: AppImageSource.SystemName, color: Color.signifierColor, component: {})
                        }).sheet(isPresented: $showProfile) {
                            ProfileView()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showGroupMember = true
                        }, label: {
                            AppImage(url: "plus", source:AppImageSource.SystemName, color: Color.signifierColor, component: {})
                        }).sheet(isPresented: $showGroupMember, onDismiss: {
                            
                                Logger.debug("should be refresh1")
                                tripListViewModel.fetchData()
                        }) {
                            TripFormView()
                        }
                    }
                }
        }
    }
}

