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

final class GlobalVariables: ObservableObject{
    
    static let global = GlobalVariables()
    
    @Published var authenticated = false
    @Published var trip : Trip?
    @Published var tripMemberList : [TripMember]?
}

struct AuthView: View {
    
    @ObservedObject var authViewModel = AuthViewModel()
    @ObservedObject var global = GlobalVariables.global
    
    var body: some View {
        if(global.authenticated == false) {
            ZStack{
                Color.tertiaryColor.ignoresSafeArea(.all)
                VStack{
                    Spacer()
                    Image("Logo")
                    HStack{
                        AppTitle1(text: "Welcome to", color: Color.primaryColor, fontWeight: .regular, fontSize: 24)
                        AppTitle1(text: "Tribie!👋", color: Color.signifierColor, fontWeight: .bold, fontSize: 24)
                    }
                    AppTitle1(text: " Your Travel Bills & Expense Manager", color: Color.primaryColor, fontWeight: .regular, fontSize: 15)
                    Spacer()
                    ZStack{
                        AppCard(width: 280, height: 48, cornerRadius: 10, backgroundColor: Color.tertiaryColor, borderColor: Color.signifierColor, component: {})
                        VStack{
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
                            }.frame(width: 260, height: 40)
                        }
                        
                    }
                }
            }
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
