//
//  SplitBillViewModel.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation
import Combine
import RxSwift

class TripMemberFormViewModel: ObservableObject {
    @Published var state: AppState = AppState.Initial
    @Published var trip: Trip?
    
    private var repository: NetworkRepository = NetworkRepository()
    private let disposeBag: DisposeBag =  DisposeBag()
    
    @Published var user: User?
    @Published var email: String?
    @Published var userList: [User] = []
    @Published var selectedUserList: [TripMember] = []
    @Published var global = GlobalVariables.global

    public func fetchUserList()  {
        Logger.debug("fetch user")
        repository.getUserList()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.userList = response ?? []
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func addTripMember()  {
        if(global.$tripMemberList == nil) {
            global.tripMemberList = []
            global.tripMemberList.append(TripMember(
                id: Random.randomString(length: 10),
                userId: user!.id!,
                name: user!.name!,
                saved: false
            ))
        } else {
            global.tripMemberList.append(TripMember(
                id: Random.randomString(length: 10),
                userId: user!.id!,
                name: user!.username!,
                saved: false
            ))
        }
        Logger.error("-----")
        Logger.error(global.tripMemberList)
    }
    
    public func updateTrip(tripId: String = AppConstant.DUMMY_DATA_TRIP_ID)  {
        state = AppState.Loading
        repository.updateTrip(id: tripId, trip: trip!)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.trip = response ?? Trip()
                self.state = AppState.Finish
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func searchUser() {
        self.user = userList.first(where: {$0.email == email?.lowercased()}) ?? User()
    }
    
    public func fetchData(selectedUser: [TripMember]) {
        self.state = AppState.Loading
        self.selectedUserList = selectedUser
        self.fetchUserList()
    }
}
