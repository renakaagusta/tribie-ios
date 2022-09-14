//
//  TripMemberFormView.swift
//  tribie
//
//  Created by renaka agusta on 12/09/22.
//

import SwiftUI

struct TripMemberFormView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var global = GlobalVariables.global
    @State var searchMember: String = ""
    @ObservedObject var tripMemberFormViewModel: TripMemberFormViewModel = TripMemberFormViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if(tripMemberFormViewModel.user != nil) {
                    if(tripMemberFormViewModel.user?.username != nil) {
                            AppCircleImage(component: {})
                            AppTitle1(text: (tripMemberFormViewModel.user?.username)!)
                            AppElevatedButton(label: "Add", onClick: {
                                tripMemberFormViewModel.addTripMember()
                                presentationMode.wrappedValue.dismiss()
                            })
                    } else {
                        AppBody1(text: "User not found")
                    }
                }
                if(tripMemberFormViewModel.user == nil) { AppTextField(placeholder: "Apple id", field: Binding(get: {tripMemberFormViewModel.email ?? ""}, set: {tripMemberFormViewModel.email = $0}))
                    AppElevatedButton(label: "Search", onClick: {
                        tripMemberFormViewModel.searchUser()
                    })
                }
            }
            .navigationTitle("Add Members")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        AppBody1(text: "Done", color: Color.primaryColor, fontWeight: .bold)
                    })
                }
            }
        }.onAppear {
            tripMemberFormViewModel.fetchData(selectedUser: global.tripMemberList)
        }
    }
}

struct TripMemberFormView_Previews: PreviewProvider {
    static var previews: some View {
        TripMemberFormView()
    }
}
