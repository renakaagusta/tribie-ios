//
//  TripListViewModel.swift
//  tribie
//
//  Created by renaka agusta on 03/09/22.
//

import Foundation
import RxSwift

class TripListViewModel: ObservableObject {
    
    @Published var state: AppState = AppState.Initial
    
    @Published var userId: String = AppKeychain().userId()
    
    @Published var tripList: [Trip]?
    @Published var filteredTripList: [Trip]?
    @Published var tripMemberList: [TripMember]?
    
    private var repository: NetworkRepository = NetworkRepository()
    private let disposeBag: DisposeBag =  DisposeBag()
    
    public func fetchTripList() {
        repository.getTripList()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                if(self.tripList == nil) {
                    self.tripList =  []
                    if (response != nil) {
                        self.tripList = response!
                    }
                    if (self.tripList!.count != 0) {
                        self.state = AppState.Exist
                    } else {
                        self.state = AppState.Empty
                    }
                }
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func fetchTripMemberList(){
        repository.getAllTripMemberList()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.tripMemberList = response ?? []
                if (self.tripMemberList!.count != 0) {
                    self.state = AppState.Exist
                } else {
                    self.state = AppState.Empty
                }
            }, onError: {error in
                Logger.error("oops")
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func filterTripList() {
        self.filteredTripList = []
        for trip in self.tripList! {
            if (tripMemberList!.first(where: {$0.userId == self.userId}) != nil) {
                if(self.filteredTripList == nil) {
                    self.filteredTripList = []
                }
                self.filteredTripList!.append(trip)
            }
        }
    }
    
    public func fetchData() {
        self.state = AppState.Loading
        fetchTripList()
        fetchTripMemberList()
    }
}
