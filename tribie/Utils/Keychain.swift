//
//  Keychain.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Keychain

class AppKeychain {
    private lazy var keyChain = Keychain()
    
    func appToken() -> String {
        return String(describing: keyChain.value(forKey: AppConstant.KEYCHAIN_TOKEN)!)
    }
    
    func setAppToken(token: String) {
        self.keyChain.save(token, forKey: AppConstant.KEYCHAIN_TOKEN)
    }
    
    func isTokenEmpty() -> Bool {
        return appToken().isEmpty
    }
}
