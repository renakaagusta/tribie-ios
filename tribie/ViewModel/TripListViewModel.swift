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
    
    @Published var moveToTripView: Bool = false
    
    @Published var transactionList: [Transaction]?
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
                    self.filterTripList()
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
                self.filterTripList()
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func filterTripList() {
        if(tripMemberList == nil || tripList == nil) {
            return
        }
        
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
    
    public func fetchTransactionList() {
        repository.getTransactionList()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                if(self.transactionList == nil) {
                    self.transactionList =  []
                    if (response != nil) {
                        self.transactionList = response!
                    }
                }
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func getTotalTripSpending(tripId: String) -> Int {
        var totalTripSpending: Int = 0
        
        for transaction in transactionList! {
            if(transaction.tripId == tripId) {
                totalTripSpending += transaction.grandTotal ?? 0
            }
        }
        
        return totalTripSpending
    }
    
    public func getTripMemberNameList(tripId: String) -> String {
        var tripMemberNameList = ""
        
        for tripMember in tripMemberList! {
            if(tripMember.tripId == tripId) {
                tripMemberNameList += (", " + tripMember.name!) ?? ", -"
            }
        }
        
        return tripMemberNameList
    }
    
    public func fetchData() {
        self.state = AppState.Loading
        fetchTripList()
        fetchTransactionList()
        fetchTripMemberList()
    }
}
