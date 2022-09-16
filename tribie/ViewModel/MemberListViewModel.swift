//
//  MemberListViewModel.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation
import RxSwift

class MemberListViewModel: ObservableObject {
    
    @Published var state: AppState = AppState.Initial
    
    @Published var trip: Trip?
    @Published var transactionItemList: [TransactionItem]?
    @Published var tripMemberList: [TripMember]?
    @Published var transactionExpensesList: [TransactionExpenses]?
    @Published var transactionList: [Transaction]?
    
    @Published var successSendCounter: Int = 0
    @Published var moveToTripView: Bool = false
    
    private var repository: NetworkRepository = NetworkRepository()
    private let disposeBag: DisposeBag =  DisposeBag()
    
    public func fetchTransactionItemList(transactionId: String = AppConstant.DUMMY_DATA_TRANSACTION_ID) {
        repository.getTransactionItemList(transactionId: transactionId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.transactionItemList = response ?? []
                if (self.transactionItemList!.count != 0) {
                        self.state = AppState.Exist
                } else {
                    self.state = AppState.Empty
                }
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func fetchTripMemberList(tripId: String){
        repository.getTripMemberList(tripId: tripId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.tripMemberList = response ?? []
                if (self.tripMemberList!.count != 0) {
                    self.state = AppState.Exist
                } else {
                    self.state = AppState.Empty
                }
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func fetchTransactionExpensesList(tripId: String) {
        repository.getTripTransactionExpensesList(tripId: tripId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.transactionExpensesList = response ?? []
                if (self.transactionExpensesList!.count != 0) {
                    self.state = AppState.Exist
                } else {
                    self.state = AppState.Empty
                }
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func submitTripMember() {
        for tripMember in tripMemberList! {
            if(tripMember.saved == false) {
                repository.addTripMember(tripMember: tripMember)
                        .observe(on: MainScheduler.instance)
                        .subscribe(onNext: { response in
                            if(response != nil) {
                                self.successSendCounter += 1
                                if(self.successSendCounter == self.tripMemberList!.count) {
                                    self.moveToTripView = true
                                }
                            } else {
                                self.state = AppState.Error
                            }
                    }, onError: {error in
                        self.state = AppState.Error
                    }).disposed(by: disposeBag)
            } else {
                repository.updateTripMember(id: tripMember.tripId!, tripMember: tripMember)
                        .observe(on: MainScheduler.instance)
                        .subscribe(onNext: { response in
                            if(response != nil) {
                                self.successSendCounter += 1
                                if(self.successSendCounter == self.tripMemberList!.count) {
                                    self.moveToTripView = true
                                }
                            } else {
                                self.state = AppState.Error
                            }
                        }, onError: {error in
                            self.state = AppState.Error
                        }).disposed(by: disposeBag)
                }
            }
    }
    
    public func addTripMember() {
        self.tripMemberList!.append(TripMember(id: Random.randomString(length: 10), tripId: trip!.id!, name: "", saved: false, status: "Invited"))
    }

    public func getMemberExpenses(memberId: String) -> Int {
        var totalExpenses: Int = 0
        
        for memberExpenses in transactionExpensesList! {
            if memberExpenses.tripMemberId == memberId {
                totalExpenses += memberExpenses.quantity! * Int(transactionItemList!.first(where: {$0.id == memberExpenses.itemId})!.price!)
            }
        }
        
        return totalExpenses
    }
    
    public func fetchData() {
//        self.state = AppState.Exist
//        fetchTripMemberList()
//        fetchTransactionItemList()
//        fetchTransactionExpensesList()
//        fetchTransactionItemList()
    }
}
