//
//  ProfileView.swift
//  tribie
//
//  Created by renaka agusta on 12/09/22.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var profileViewModel : ProfileViewModel = ProfileViewModel()
    
    var body: some View {
        return VStack {
            HStack {
                AppCircleImage(size: 40.0, component: {})
                Spacer().frame(width: 10.0)
                VStack(alignment: .leading) {
                    Text(profileViewModel.userName)
                    Text(profileViewModel.userMail)
                }
                Spacer()
            }.padding().background(Color.white).cornerRadius(10)
            AppElevatedButton(label: "Sign Out", onClick: profileViewModel.signOut)
        }.padding().onAppear{
            profileViewModel.fetchData()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
