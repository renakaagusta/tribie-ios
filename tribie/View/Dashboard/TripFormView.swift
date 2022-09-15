//
//  FormTripView.swift
//  tribie
//
//  Created by I Gede Bagus Wirawan on 09/09/22.
//

import SwiftUI

struct TripFormView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showAddMemberModalView: Bool = false
    
    @ObservedObject var global = GlobalVariables.global
    @ObservedObject var tripFormViewModel : TripFormViewModel = TripFormViewModel()
    var tripId: String?
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment:.leading){
                        HStack{
                            AppBody1(text: "Group Trip Name", color: Color.secondaryColor, textAlign: .trailing).padding(.horizontal)
                            Spacer()
                        }
                        AppTextField( placeholder: "Input Name",field: Binding(get: {tripFormViewModel.trip.title ?? ""}, set: {tripFormViewModel.trip.title = $0}))
                    }
                    
                    VStack(alignment:.leading){
                        HStack{
                            AppBody1(text: "Member", color: Color.secondaryColor, textAlign: .trailing).padding(.horizontal)
                            Spacer()
                        }
                    }
                    
                    if(tripId == nil) {
                        ForEach(global.tripMemberList) { tripMember in
                            MemberSpendingCard(image: AppCircleImage(size: 40.0, component: {}), userName: tripMember.name ?? "", amount:0)
                        }.onAppear {
                            tripFormViewModel.fetchData(tripId: tripId, tripMemberList: global.tripMemberList)
                        }
                    }
                    if(tripId != nil) {
                        if(tripFormViewModel.tripMemberList != nil) {
                            ForEach(tripFormViewModel.tripMemberList) { tripMember in
                                MemberSpendingCard(image: AppCircleImage(size: 40.0, component: {}), userName: tripMember.name ?? "", amount:0)
                            }.onAppear {
                                tripFormViewModel.fetchData(tripId: tripId, tripMemberList: global.tripMemberList)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Group Trip")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        if(tripFormViewModel.trip.title != nil) {
                            tripFormViewModel.submitTrip(complete: {
                                presentationMode.wrappedValue.dismiss()
                            }, tripMemberList: global.tripMemberList)
                        } else {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }, label: {
                        AppBody1(text: "Done", color: Color.signifierColor, fontWeight: .bold)
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    AppImageButton(height: 20, width: 20, image: AppImage(height: 20, width: 20, url: "person.fill.badge.plus", source: AppImageSource.SystemName, color: Color.signifierColor, component: {}), onClick: {
                        self.showAddMemberModalView.toggle()
                    })
                    .sheet(isPresented: $showAddMemberModalView) {
                        TripMemberFormView()
                    }
                }
            }
        }
    }
}

struct FormTripView_Previews: PreviewProvider {
    static var previews: some View {
        TripFormView()
            
    }
}
