//
//  TripListView.swift
//  tribie
//
//  Created by renaka agusta on 03/09/22.
//

import SwiftUI

struct TripListView: View {

    @ObservedObject var tripListViewModel: TripListViewModel = TripListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                AppTitle1(text: "Trips")
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
                        if(tripListViewModel.tripList != nil && tripListViewModel.tripMemberList != nil) {
                            VStack {
                                if(tripListViewModel.filteredTripList != nil) {
                                    ForEach(tripListViewModel.filteredTripList!) { trip in
                                        NavigationLink(destination: TripView(tripId: trip.id!)){
                                            AppCard(width: UIScreen.width, height: 40, backgroundColor: Color.white, component: {
                                                AppBody1(text: trip.title!)
                                            })
                                        }
                                    }
                                }
                            }.padding().onAppear {
                                tripListViewModel.filterTripList()
                            }
                        }
                        if(tripListViewModel.tripList == nil) {
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
            }
            .navigationTitle("Recent Trip")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }
}
