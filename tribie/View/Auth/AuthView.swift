//
//  Auth.swift
//  macnivision
//
//  Created by renaka agusta on 16/07/22.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct AuthView: View {
    
    @ObservedObject var authViewModel = AuthViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                AppElevatedButton(
                    label: "Login By Apple",
                    onClick: {
                        Task {
                            await authViewModel.handleSignInWithApple()
                        }
                    }
                )
                AppOutlinedButton(
                    label: "Login By Device",
                    onClick: {
                        Task {
                            await authViewModel.handleSignInWithDevice()
                        }
                    }
                )
                NavigationLink(destination: TripListView(), isActive:  $authViewModel.moveToDashboard) {
                    AppOutlinedButton(
                        label: "Login By Email",
                        onClick: {
                            Task {
                                await authViewModel.handleSignIn()
                            }
                        }
                    )
                }
            }.background(
                Color.tertiaryColor
            ).padding()
        }
    }

}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().preferredColorScheme(scheme)
    }
}
