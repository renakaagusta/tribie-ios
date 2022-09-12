//
//  Auth.swift
//  macnivision
//
//  Created by renaka agusta on 16/07/22.
//

import Foundation
import SwiftUI
import AuthenticationServices
import UIKit

struct AuthView: View {
    
    @ObservedObject var authViewModel = AuthViewModel()
    
    var body: some View {
            VStack{
                NavigationLink(destination: TripListView(), isActive:  $authViewModel.moveToDashboard) {SignInWithAppleButton(.continue){ request in
                    request .requestedScopes = [.email, .fullName]
                } onCompletion: { result in
                    switch result {
                    case .success(let auth):
                        switch auth.credential {
                        case let credential as ASAuthorizationAppleIDCredential:
                            let userId = credential.user
                            let email = credential.email
                            let firstname = credential.fullName!.givenName
                            let lastname = credential.fullName!.familyName
                            
                            Logger.debug(credential)
                            
                            if(email != nil) {
                                authViewModel.handleSignUp(email: email, name: firstname! + lastname!, appleId: userId, deviceId: UIDevice.current.identifierForVendor!.uuidString)
                            } else {
                                authViewModel.handleSignIn()
                            }
                        default:
                            break
                        }
                    case .failure(let error):
                        print("Error")
                        print(error)
                    }
                }.frame(width: 320, height: 40)}
            }.background(
                Color.tertiaryColor
            ).padding()
        }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().preferredColorScheme(scheme)
    }
}
