//
//  TripListView.swift
//  tribie
//
//  Created by renaka agusta on 03/09/22.
//

import SwiftUI

struct TripListView: View {
    
    //variable for modal
    @State var showGroupMember: Bool = false
    @State var showProfile: Bool = false

    @State var tripId: String = AppConstant.DUMMY_DATA_TRIP_ID
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
                if(tripListViewModel.tripList == nil) {
                    tripListViewModel.fetchData()
                }
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
                        }).sheet(isPresented: $showGroupMember) {
                            TripFormView()
                        }
                    }
                }
        }
    }
}

