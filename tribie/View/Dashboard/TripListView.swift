//
//  TripListView.swift
//  tribie
//
//  Created by renaka agusta on 03/09/22.
//

import SwiftUI

struct TripListView: View {

    @State var tripId: String = AppConstant.DUMMY_DATA_TRIP_ID
    @ObservedObject var tripListViewModel: TripListViewModel = TripListViewModel()
    
    var body: some View {
            VStack {
                AppTitle1(text: "Trip")
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
                                    ForEach(tripListViewModel.tripList!) { trip in
                                        NavigationLink(destination: MainView(tripId: trip.id!)){
                                            AppCard(width: UIScreen.width, height: 40, backgroundColor: Color.white, component: {
                                                AppBody1(text: trip.title!)
                                            })
                                        }
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
    }
}
