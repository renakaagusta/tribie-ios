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
    @ObservedObject var global = GlobalVariables.global
    
    var body: some View {
        if(global.authenticated == false) {
            VStack{
                AppElevatedButton(label: "Sign in", onClick:{
                    authViewModel.handleSignInWithApple(appleId: "002001.199e1e71462345a59a0175093ef1f754.0245")
                })
                    SignInWithAppleButton(.continue){ request in
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
                            
                            if(email != nil) {
                                authViewModel.handleSignUp(email: email, name: firstname! + lastname!, appleId: userId, deviceId: UIDevice.current.identifierForVendor!.uuidString)
                            } else {
                                authViewModel.handleSignInWithApple(appleId: userId)
                            }
                        default:
                            break
                        }
                    case .failure(let error):
                        Logger.error(error)
                    }
                }.frame(width: 320, height: 40)
            }.background(
                Color.tertiaryColor
            ).padding()
        } else {
            TripListView()
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().preferredColorScheme(scheme)
    }
}
