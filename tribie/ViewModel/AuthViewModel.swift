//
//  SplitBillViewModel.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation
import Combine
import RxSwift

class AuthViewModel: ObservableObject {
    @Published var state: AppState = AppState.Initial
    @Published var signInResponse: SignInResponse?
    @Published var moveToDashboard: Bool = false
    
    private var repository: NetworkRepository = NetworkRepository()
    private let disposeBag: DisposeBag =  DisposeBag()
    
    public func handleSignIn(email: String = AppConstant.DUMMY_DATA_USER_EMAIL, password: String = AppConstant.DUMMY_DATA_USER_PASSWORD) async {
        let signInRequest = SignInRequest(
            email: email,
            password: password
        )
        
        repository.signIn(request: signInRequest)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                Logger.debug(response)
                if(response != nil) {
                    AppKeychain().setAppToken(token: response!.token!)
                    AppKeychain().setUserId(userId: response!.user.id!)
                    self.signInResponse = response
                    self.moveToDashboard = true
                } else {
                    self.state = AppState.Error
                }
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func handleSignInWithApple(appleId: String = AppConstant.DUMMY_DATA_USER_APPLE_ID) async {
        let signInRequest = SignInRequest(
            appleId: appleId
        )
        
        repository.signInWithApple(request: signInRequest)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                Logger.debug(response)
                if(response != nil) {
                    AppKeychain().setAppToken(token: response!.token!)
                    AppKeychain().setUserId(userId: response!.user.id!)
                    self.signInResponse = response
                } else {
                    self.state = AppState.Error
                }
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func handleSignInWithDevice(deviceId: String = AppConstant.DUMMY_DATA_USER_DEVICE_ID) async {
        let signInRequest = SignInRequest(
            deviceId: deviceId
        )
        
        repository.signInWithDevice(request: signInRequest)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                Logger.debug(response)
                if(response != nil) {
                    AppKeychain().setAppToken(token: response!.token!)
                    AppKeychain().setUserId(userId: response!.user.id!)
                    self.signInResponse = response
                } else {
                    self.state = AppState.Error
                }
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
}