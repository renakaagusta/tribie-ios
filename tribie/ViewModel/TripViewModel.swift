//
//  MemberSpendingViewModel.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation
import RxSwift

class TripViewModel: ObservableObject {
    @Published var state: AppState = AppState.Initial
    @Published var transactionList: [Transaction]?
    @Published var transactionItemList: [TransactionItem]?
    @Published var tripMemberList: [TripMember]?
    @Published var transactionExpensesList: [TransactionExpenses]?
    @Published var transactionSettlementList: [TransactionSettlement]?
    
    private var repository: NetworkRepository = NetworkRepository()
    private let disposeBag: DisposeBag =  DisposeBag()
    
    public func fetchTripTransactionList(tripId: String = AppConstant.DUMMY_DATA_TRIP_ID){
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
    
    public func fetchTransactionItemList(tripId: String = AppConstant.DUMMY_DATA_TRANSACTION_ID){
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
    
    public func fetchTripMemberList(tripId: String = AppConstant.DUMMY_DATA_TRIP_ID) {
        repository.getTripMemberList(tripId: tripId)
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
    
    public func fetchTransactionExpensesList(tripId: String = AppConstant.DUMMY_DATA_TRANSACTION_ID) {
        repository.getTripTransactionExpensesList(tripId: tripId)
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
    
    public func fetchTransactionSettlementList(tripId: String = AppConstant.DUMMY_DATA_TRIP_ID){
        repository.getTripTransactionSettlementList(tripId: tripId)
            .subscribe(onNext: { response in
                self.transactionSettlementList = response ?? []
                if (self.transactionSettlementList!.count != 0) {
                    self.state = AppState.Exist
                } else {
                    self.state = AppState.Empty
                }
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    func calculateTotalExpenses() -> Int {
        var totalExpenses: Int = 0
        
        for transactionExpenses in transactionExpensesList! {
            totalExpenses += transactionExpenses.quantity! * Int(transactionItemList!.first(where: { $0.id == transactionExpenses.itemId})!.price!)
        }
        return totalExpenses
    }
    
    func calculateTotalExpensesPerTransaction(transactionId: String) -> Int {
        var totalExpensesPerTransaction: Int = 0
        
        for transactionExpenses in transactionExpensesList! {
            if(transactionExpenses.transactionId == transactionId){
                totalExpensesPerTransaction += transactionExpenses.quantity! * Int(transactionItemList!.first(where: { $0.id == transactionExpenses.itemId})!.price!)
            }
            return totalExpensesPerTransaction
        }
        
        return totalExpensesPerTransaction
    }
    
    func getUserPaid(userPaidId: String) -> TripMember {
        if(tripMemberList!.count > 0){
            return tripMemberList![0]
        } else {
            return TripMember(name:"-")
        }
    }
    
    func getUserName(tripMemberId: String) -> String {
        return tripMemberList!.first(where: {$0.id == tripMemberId})!.name ?? "-"
    }
    
    public func fetchData(tripId: String?) {
        self.state = AppState.Loading
        fetchTripTransactionList(tripId: tripId ?? "")
        fetchTripMemberList(tripId: tripId ?? "")
        fetchTransactionItemList(tripId: tripId ?? "")
        fetchTransactionExpensesList(tripId: tripId ?? "")
        fetchTransactionSettlementList(tripId: tripId ?? "")
    }
}
