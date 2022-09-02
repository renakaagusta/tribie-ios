//
//  SplitBillViewModel.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation
import RxSwift

class SplitBillListViewModel: ObservableObject {
    @Published var state: AppState = AppState.Initial
    @Published var transaction: Transaction?
    @Published var transactionExpensesList: [TransactionExpenses] = []
    @Published var transactionItemList: [TransactionItem] = []
    @Published var tripMemberList: [TripMember] = []
    @Published var grandTotal : Int = 0
    @Published var subTotal : Int = 0
    @Published var userPaid : TripMember?
    
    private var repository: NetworkRepository = NetworkRepository()
    private let disposeBag: DisposeBag =  DisposeBag()
    
    public func fetchTransaction(){
        do {
            repository.getTransactionData(transactionId: AppConstant.DUMMY_DATA_TRANSACTION_ID)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { response in
                    self.transaction = response!
                    if (self.transaction != nil) {
                        self.state = AppState.Exist
                    } else {
                        self.state = AppState.Empty
                    }
                }, onError: {error in
                    self.state = AppState.Error
                }).disposed(by: disposeBag)
        } catch  let error {
            state = AppState.Error
        }
    }
    
    public func fetchTransactionItemList(){
        do {
            repository.getTransactionItemList(transactionId:
                                                AppConstant.DUMMY_DATA_TRANSACTION_ID)
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
            if (transactionItemList.count != 0) {
                self.state = AppState.Exist
            } else {
                self.state = AppState.Empty
            }
        } catch let error {
            state = AppState.Error
        }
    }
    
    public func fetchTransactionExpensesList(){
        do {
            repository.getTransactionExpensesList(transactionId:
                                                AppConstant.DUMMY_DATA_TRANSACTION_ID)
                .observe(on: MainScheduler.instance)
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
            if (transactionItemList.count != 0) {
                self.state = AppState.Exist
            } else {
                self.state = AppState.Empty
            }
        } catch let error {
            state = AppState.Error
        }
    }
    
    public func fetchTripMemberList(){
        do {
            repository.getTripMemberList(tripId: AppConstant.DUMMY_DATA_TRIP_ID)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { response in
                    print("----FETCH TRIP MMEBER LIST--")
                    print(response)
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
    
    public func getUserPaid() -> TripMember {
        if(transaction != nil && tripMemberList.count > 0) {
            return self.tripMemberList.first(where: {$0.id == self.transaction?.userPaidId}) ?? TripMember(name: "Renaka")
        } else {
            return  TripMember(name: "-")
        }
    }
    
    public func getTransactionTotal() -> Int {
        return 0
    }
    
    public func fetchData() {
        self.state = AppState.Loading
        fetchTransaction()
        fetchTransactionItemList()
        fetchTripMemberList()
    }
}
