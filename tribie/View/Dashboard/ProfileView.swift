//
//  ProfileView.swift
//  tribie
//
//  Created by renaka agusta on 12/09/22.
//

import SwiftUI

struct ProfileView: View {
    
    //for Modal Environment
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var profileViewModel : ProfileViewModel = ProfileViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack {
                HStack {
                    AppCircleImage(size: 40.0, component: {})
                    Spacer().frame(width: 10.0)
                    VStack(alignment: .leading) {
                        AppBody1(text: profileViewModel.userName, color: Color.primaryColor)
                        AppBody1(text: profileViewModel.userMail, color: Color.primaryColor)
                    }
                    Spacer()
                }.padding().background(Color.cardColor).cornerRadius(10)
                
                AppElevatedButton(label: "Sign Out", color: Color.black, backgroundColor: Color.signifierColor, onClick: profileViewModel.signOut)
                
                Spacer()
            }.padding().onAppear{
                profileViewModel.fetchData()
            }
            .navigationTitle("Account")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                //for leading navigation bar items
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        //action
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        AppBody1(text: "Done", color: Color.signifierColor, fontWeight: .bold)
                    })
                }
            } //toolbar
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
