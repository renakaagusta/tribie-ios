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
        return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjE5Mjg2NjUsImlkIjoiMTAwIiwibmFtZSI6ImRlbW8ifQ.ezPc7N42AkeXJ5B0PduhVvp60mk_eNAbkaZ4QxUxpzc"
        //return String(describing: keyChain.value(forKey: AppConstant.KEYCHAIN_TOKEN)!)
    }
    
    func setAppToken(token: String) {
        self.keyChain.save(token, forKey: AppConstant.KEYCHAIN_TOKEN)
    }
    
    func isTokenEmpty() -> Bool {
        return appToken().isEmpty
    }
}
