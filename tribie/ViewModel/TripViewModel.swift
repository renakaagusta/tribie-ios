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
    @Published var transactionList: [Transaction] = []
    @Published var transactionItemList: [TransactionItem] = []
    @Published var tripMemberList: [TripMember] = []
    @Published var transactionExpensesList: [TransactionExpenses] = []
    @Published var transactionSettlementList: [TransactionSettlement] = []
    
    private var repository: NetworkRepository = NetworkRepository()
    private let disposeBag: DisposeBag =  DisposeBag()
    
    public func fetchTripTransactionList(){
        do {
            repository.getTripTransactionList(tripId: AppConstant.DUMMY_DATA_TRIP_ID)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { response in
                    self.transactionList = response!
                    if (self.transactionList.count != 0) {
                        self.state = AppState.Exist
                    } else {
                        self.state = AppState.Empty
                    }
                }, onError: {error in
                    self.state = AppState.Error
                }).disposed(by: disposeBag)
        } catch let error {
            state = AppState.Error
        }
    }
    
    public func fetchTransactionItemList(){
        do {
            repository.getTransactionItemList(transactionId: AppConstant.DUMMY_DATA_TRANSACTION_ID)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { response in
                    self.transactionItemList = response!
                    if (self.transactionItemList.count != 0) {
                        self.state = AppState.Exist
                    } else {
                        self.state = AppState.Empty
                    }
                }, onError: {error in
                    self.state = AppState.Error
                }).disposed(by: disposeBag)
        } catch let error {
            state = AppState.Error
        }
    }
    
    public func fetchTripMemberList(){
        do {
            repository.getTripMemberList(tripId: AppConstant.DUMMY_DATA_TRIP_ID)
                .subscribe(onNext: { response in
                    self.tripMemberList = response!
                    if (self.tripMemberList.count != 0) {
                        self.state = AppState.Exist
                    } else {
                        self.state = AppState.Empty
                    }
                }, onError: {error in
                    self.state = AppState.Error
                }).disposed(by: disposeBag)
        } catch let error {
            state = AppState.Error
        }
    }
    
    public func fetchTransactionExpensesList(){
        do {
            repository.getTransactionExpensesList(transactionId:
                                                    AppConstant.DUMMY_DATA_TRANSACTION_ID)
                .subscribe(onNext: { response in
                    self.transactionExpensesList = response!
                    if (self.transactionExpensesList.count != 0) {
                        self.state = AppState.Exist
                    } else {
                        self.state = AppState.Empty
                    }
                }, onError: {error in
                    self.state = AppState.Error
                }).disposed(by: disposeBag)
        } catch let error {
            state = AppState.Error
        }
    }
    
    public func fetchTransactionSettlementList(){
        do {
            repository.getTransactionSettlementList(transactionId:
                                                        AppConstant.DUMMY_DATA_TRANSACTION_ID)
                .subscribe(onNext: { response in
                    self.transactionSettlementList = response!
                    if (self.transactionSettlementList.count != 0) {
                        self.state = AppState.Exist
                    } else {
                        self.state = AppState.Empty
                    }
                }, onError: {error in
                    self.state = AppState.Error
                }).disposed(by: disposeBag)
        } catch let error {
            state = AppState.Error
        }
    }
    
    public func fetchData() {
        self.state = AppState.Loading
        fetchTripTransactionList()
        fetchTripMemberList()
        fetchTransactionItemList()
        fetchTransactionExpensesList()
    }
}
