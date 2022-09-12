//
//  ProfileViewModel.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation
import RxSwift

class ProfileViewModel: ObservableObject {
    
    @Published var userName: String = ""
    @Published var userMail: String = ""
    @Published var moveToAuth: Bool = false
    
    public func fetchData() {
        self.userName = AppKeychain().userName()
        self.userMail = AppKeychain().userMail()
    }
    
    public func signOut() {
        AppKeychain().removeUserMail()
        AppKeychain().removeUserName()
        AppKeychain().removeAppToken()
        GlobalVariables.global.authenticated = false
    }
}
