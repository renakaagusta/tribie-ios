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
    
    @Published var transactionItemList: [TransactionItem] = []
    @Published var tripMemberList: [TripMember] = []
    @Published var transactionExpensesList: [TransactionExpenses] = []
    @Published var transactionList: [Transaction] = []
    
    private var repository: NetworkRepository = NetworkRepository()
    private let disposeBag: DisposeBag =  DisposeBag()
    
    public func fetchTransactionItemList(){
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
    
    public func fetchTripMemberList(){
        do {
            repository.getTripMemberList(tripId: "9c25dafa-e299-409e-a84d-1c69f49df028")
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { response in
                    self.tripMemberList = response ?? []
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
            repository.getTripTransactionExpensesList(tripId: "9c25dafa-e299-409e-a84d-1c69f49df028")
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
        } catch let error {
            state = AppState.Error
        }
    }
    
    //for get member expenses
    public func getMemberExpenses(memberId: String) -> Int {
        var totalExpenses: Int = 0
        
        for memberExpenses in transactionExpensesList {
            if memberExpenses.tripMemberId == memberId {
                totalExpenses += memberExpenses.quantity! * Int(transactionItemList.first(where: {$0.id == memberExpenses.itemId})!.price!)
            }
        }
        
        return totalExpenses
    }
    
    public func fetchData() {
        self.state = AppState.Loading
        fetchTripMemberList()
//        fetchTransactionItemList()
//        fetchTransactionExpensesList()
//        fetchTransactionItemList()
    }
}
