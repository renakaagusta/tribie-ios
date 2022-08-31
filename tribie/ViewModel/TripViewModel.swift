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
    
    public func fetchTransactionList(){
        do {
            repository.getTransactionItemList(transactionId: "7fec302b-a335-412b-99c7-271011c81cc2")
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { response in
                    self.transactionItemList = response!
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
            self.transactionItemList = [
                TransactionItem(id: "0",title: "Nasi Putih", price: 10000, quantity: 3),
                TransactionItem(id: "1",title: "Nasi Putih", price: 10000, quantity: 3),
                TransactionItem(id: "2",title: "Nasi Putih", price: 10000, quantity: 3)
            ]
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
            self.tripMemberList = [
                TripMember(id: "0", tripId: "", userId: "", name: "Kaka"),
                TripMember(id: "1", tripId: "", userId: "", name: "Arnold"),
                TripMember(id: "2", tripId: "", userId: "", name: "Gusde"),
            ]
            if (tripMemberList.count != 0) {
                self.state = AppState.Exist
            } else {
                self.state = AppState.Empty
            }
        } catch  let error {
            state = AppState.Error
        }
    }
    
    public func fetchTransactionExpensesList(){
        do {
            self.transactionExpensesList = [
                TransactionExpenses(id: "0", itemId: "0", tripMemberId: "0", transactionId: "0", quantity: 1),
                TransactionExpenses(id: "1", itemId: "1", tripMemberId: "1", transactionId: "1", quantity: 3),
                TransactionExpenses(id: "2", itemId: "2", tripMemberId: "2", transactionId: "2", quantity: 2),
            ]
            if (transactionExpensesList.count != 0) {
                self.state = AppState.Exist
            } else {
                self.state = AppState.Empty
            }
        } catch  let error {
            state = AppState.Error
        }
    }
    
    public func fetchTransactionSettlementList(){
        do {
            self.transactionSettlementList = []
 
            if (transactionSettlementList.count != 0) {
                self.state = AppState.Exist
            } else {
                self.state = AppState.Empty
            }
        } catch  let error {
            state = AppState.Error
        }
    }
    
    public func fetchData() {
        self.state = AppState.Loading
        fetchTransactionList()
        fetchTripMemberList()
        fetchTransactionItemList()
        fetchTransactionExpensesList()
    }
}
