//
//  TransactionListViewModel.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation
import RxSwift

class TransactionListViewModel: ObservableObject {
    
    @Published var state: AppState = AppState.Initial
    
    @Published var transactionItemList: [TransactionItem]?
    @Published var tripMemberList: [TripMember]?
    @Published var transactionExpensesList: [TransactionExpenses]?
    @Published var transactionList: [Transaction]?
    
    private var repository: NetworkRepository = NetworkRepository()
    private let disposeBag: DisposeBag =  DisposeBag()
    
    public func fetchTransactionList(tripId: String = AppConstant.DUMMY_DATA_TRIP_ID){
        repository.getTripTransactionList(tripId: tripId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.transactionList = response ?? []
                if (self.transactionList!.count != 0) {
                    self.state = AppState.Exist
                } else {
                    self.state = AppState.Empty
                }
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func fetchTripTransactionItemList(tripId: String = AppConstant.DUMMY_DATA_TRANSACTION_ID){
        repository.getTripTransactionItemList(tripId: tripId)
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
    
    public func fetchTripMemberList(tripId : String = AppConstant.DUMMY_DATA_TRIP_ID){
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
    
    public func fetchTransactionExpensesList(tripId : String = AppConstant.DUMMY_DATA_TRIP_ID){
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
    
    public func fetchData(tripId: String) {
        self.state = AppState.Loading
        fetchTripMemberList(tripId: tripId)
        fetchTripTransactionItemList(tripId: tripId)
        fetchTransactionExpensesList(tripId: tripId)
        fetchTransactionList(tripId: tripId)
    }
    
    public func getTotalTransactionExpenses(transactionId: String) -> Int {
        var totalExpenses: Int = 0

        for tripExpenses in transactionExpensesList! {
            if tripExpenses.transactionId == transactionId {
                totalExpenses += tripExpenses.quantity! * Int(transactionItemList!.first(where: {$0.id == tripExpenses.itemId})!.price!)
            }
        }

        return totalExpenses
    }
    
    public func getTripMemberTransaction(tripId: String) -> String {
        var memberName: String = ""
        
        for tripMemberTransaction in tripMemberList! {
            if tripMemberTransaction.tripId == tripId {
                memberName = tripMemberTransaction.name ?? ""
            }
        }
        return memberName
    }
}
