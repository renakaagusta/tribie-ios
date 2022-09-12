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
        NavigationView{
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
                        if(tripListViewModel.tripList != nil && tripListViewModel.tripMemberList != nil) {
                            Spacer().frame(height: 10)
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
            }.navigationTitle("Trips")
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: ProfileView()){
                            AppImage(url: "person.crop.circle",source:AppImageSource.SystemName,component: {})
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: TripFormView()){
                            AppImage(url: "plus",source:AppImageSource.SystemName,component: {})
                        }
                    }
                }
        }
    }
}
