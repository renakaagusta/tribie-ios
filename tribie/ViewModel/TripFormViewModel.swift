//
//  SplitBillViewModel.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation
import Combine
import RxSwift

class TripFormViewModel: ObservableObject {
    @Published var state: AppState = AppState.Initial
    @Published var trip: Trip = Trip()
    
    private var repository: NetworkRepository = NetworkRepository()
    private let disposeBag: DisposeBag =  DisposeBag()
    
    @Published var tripMemberList: [TripMember] = []
    @Published var tripSettlementList: [TransactionSettlement] = []
    
    @Published var successSendCounter = 0
    
    public func fetchTrip(tripId: String = AppConstant.DUMMY_DATA_TRIP_ID) {
        repository.getTripData(tripId: tripId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.trip = response ?? Trip()
                self.state = AppState.Exist
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func addTrip() {
        self.state = AppState.Loading
        repository.addTrip(trip: trip)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.trip = response ?? Trip()
                self.state = AppState.Finish
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func updateTrip(tripId: String = AppConstant.DUMMY_DATA_TRIP_ID) async {
        state = AppState.Loading
        repository.updateTrip(id: tripId, trip: trip)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.trip = response ?? Trip()
                self.state = AppState.Finish
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func getMemberSpending(tripMemberId: String) -> Int {
        var totalMemberSettlement = 0
        
        for settlement in tripSettlementList {
            if(settlement.userFromId == tripMemberId) {
                totalMemberSettlement += settlement.nominal!
            }
        }
        
        return totalMemberSettlement
    }
    
    public func submitTrip(complete: @escaping () -> (), tripMemberList: [TripMember]) {
        for tripMember in tripMemberList {
            self.tripMemberList.append(tripMember)
        }
        repository.addTrip(trip: trip)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                if(response != nil) {
                    self.trip = response!
                    self.submitTripMember(complete: complete)
                } else {
                    self.state = AppState.Error
                }
            }, onError: {error in
                Logger.error(error)
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func submitTripMember(complete: @escaping () -> ()) {
        var index = 0
        for tripMember in tripMemberList {
            self.tripMemberList[index].tripId = trip.id!
            if(tripMember.saved == false) {
                repository.addTripMember(tripMember:  self.tripMemberList[index])
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { response in
                        if(response != nil) {
                            self.successSendCounter += 1
                            self.handleDismissModal(complete: complete)
                        } else {
                            self.state = AppState.Error
                        }
                    }, onError: {error in
                        Logger.error(error)
                        self.state = AppState.Error
                    }).disposed(by: disposeBag)
            } else {
                repository.updateTripMember(id: tripMember.id!, tripMember:  self.tripMemberList[index])
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { response in
                        if(response != nil) {
                            self.successSendCounter += 1
                            self.handleDismissModal(complete: complete)
                        } else {
                            self.state = AppState.Error
                        }
                    }, onError: {error in
                        Logger.error(error)
                        self.state = AppState.Error
                    }).disposed(by: disposeBag)
            }
            index += 1
        }
    }
    
    public func handleDismissModal(complete: @escaping () -> ()) {
        Logger.debug("----SUCCESS SEND COUNTER-----")
        Logger.debug("----" + String(successSendCounter) + "-----")
        if(successSendCounter == tripMemberList.count) {
            complete()
        }
    }
    
    public func fetchData(tripId: String?, tripMemberList: [TripMember]) {
        if(tripId == nil) {
            self.trip = Trip(
                title: ""
            )
        } else {
            fetchTrip(tripId: tripId!)
        }
        
        self.tripMemberList = tripMemberList
        self.state = AppState.Loading
        fetchTrip()
    }
}
