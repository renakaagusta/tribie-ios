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
        return String(describing: keyChain.value(forKey: AppConstant.KEYCHAIN_TOKEN) ?? "")
    }
    
    func setAppToken(token: String) {
        self.keyChain.save(token, forKey: AppConstant.KEYCHAIN_TOKEN)
    }
    
    func removeAppToken() {
        self.keyChain.remove(forKey: AppConstant.KEYCHAIN_TOKEN)
    }
    
    func userMail() -> String {
        return String(describing: keyChain.value(forKey: AppConstant.USER_MAIL) ?? "")
    }
    
    func setUserMail(mail: String) {
        self.keyChain.save(mail, forKey: AppConstant.USER_MAIL)
    }
    
    func removeUserMail() {
        self.keyChain.remove(forKey: AppConstant.USER_MAIL)
    }
    
    func setUserName(name: String) {
        self.keyChain.save(name, forKey: AppConstant.USER_NAME)
    }
    
    func removeUserName() {
        self.keyChain.remove(forKey: AppConstant.USER_NAME)
    }
    
    func userName() -> String {
        return String(describing: keyChain.value(forKey: AppConstant.USER_NAME) ?? "")
    }
    
    func onBoardingStatus() -> Bool {
        return keyChain.value(forKey: AppConstant.KEYCHAIN_ON_BOARDING_STATUS) != nil ? true : false
    }
    
    func setOnBoardingStatus(onBoardingStatus: Bool) {
        self.keyChain.save(onBoardingStatus, forKey: AppConstant.KEYCHAIN_ON_BOARDING_STATUS)
    }
    
    func userId() -> String {
        return String(describing: keyChain.value(forKey: AppConstant.KEYCHAIN_USER_ID) ?? "")
    }
    
    func setUserId(userId: String) {
        self.keyChain.save(userId, forKey: AppConstant.KEYCHAIN_USER_ID)
    }
    
    func tripActive() -> String {
        return String(describing: keyChain.value(forKey: AppConstant.KEYCHAIN_TRIP_ACTIVE) ?? "")
    }
    
    func setTripActive(tripActive: String) {
        self.keyChain.save(tripActive, forKey: AppConstant.KEYCHAIN_TRIP_ACTIVE)
    }
}
