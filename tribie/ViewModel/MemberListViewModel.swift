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
    
    @Published var transactionItemList: [TransactionItem]?
    @Published var tripMemberList: [TripMember]?
    @Published var transactionExpensesList: [TransactionExpenses]?
    @Published var transactionList: [Transaction]?
    
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
    
    public func fetchTripMemberList(tripId: String = AppConstant.DUMMY_DATA_TRIP_ID){
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
    
    public func fetchTransactionExpensesList(tripId: String = AppConstant.DUMMY_DATA_TRIP_ID) {
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
        self.state = AppState.Exist
        fetchTripMemberList()
        fetchTransactionItemList()
        fetchTransactionExpensesList()
        fetchTransactionItemList()
    }
}
