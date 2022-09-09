//
//  MemberItemViewModel.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation
import RxSwift

class MemberItemListViewModel: ObservableObject {
    @Published var state: AppState = AppState.Initial
    @Published var transaction: Transaction?
    @Published var transactionItemList: [TransactionItem]?
    @Published var tripMemberList : [TripMember]?
    @Published var transactionExpensesList : [TransactionExpenses]?
    @Published var selectedUserId: String?
    @Published var successSendCounter = 0
    @Published var moveToSplitBillView = false
    
    private var repository: NetworkRepository = NetworkRepository()
    private let disposeBag: DisposeBag =  DisposeBag()
    
    public func fetchTransactionItemList(transactionId: String = AppConstant.DUMMY_DATA_TRANSACTION_ID ){
        repository.getTransactionItemList(transactionId: transactionId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.transactionItemList = response!
                if (self.transactionItemList!.count != 0) {
                    self.state = AppState.Exist
                }
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func fetchTripMemberList(tripId: String = AppConstant.DUMMY_DATA_TRIP_ID){
        repository.getTripMemberList(tripId: tripId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.tripMemberList = response! ?? []
                for (index, _) in self.tripMemberList!.enumerated() {
                    self.tripMemberList![index].saved = true
                }
                if (self.tripMemberList!.count != 0) {
                    self.selectedUserId = self.tripMemberList![0].id!
                    self.state = AppState.Exist
                } else {
                    self.state = AppState.Empty
                }
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func fetchTransaction(transactionId: String = AppConstant.DUMMY_DATA_TRANSACTION_ID) {
        repository.getTransactionData(transactionId: transactionId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.transaction = response ?? Transaction()
                self.state = AppState.Exist
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func fetchTransactionExpenseList(transactionId: String = AppConstant.DUMMY_DATA_TRANSACTION_ID){
        repository.getTransactionExpensesList(transactionId: transactionId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.transactionExpensesList = response ?? []
                for (index, _) in self.transactionExpensesList!.enumerated() {
                    self.transactionExpensesList![index].saved = true
                }
                if (self.transactionExpensesList!.count != 0) {
                    self.state = AppState.Exist
                } else {
                    self.state = AppState.Empty
                }
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func handleIncrementQuantity(itemId: String, tripMemberId: String) {
        if(getRemainingQuantity(itemId: itemId) <= 0) {
            return
        }
        
        var newTransactionExpensesList = transactionExpensesList
        
        let index: Int? = transactionExpensesList!.firstIndex(where: {$0.itemId == itemId && $0.tripMemberId == tripMemberId})
        
        if(index == nil) {
            newTransactionExpensesList?.append(TransactionExpenses(
                itemId: itemId, tripMemberId: tripMemberId, tripId: transaction!.tripId!,
                transactionId: transaction!.id!,
                saved: false,
                quantity: 1
            ))
        } else {
            newTransactionExpensesList![index!].quantity! += 1
        }
        
        Logger.warning(newTransactionExpensesList)
        
        transactionExpensesList = newTransactionExpensesList
        
        Logger.debug(transactionExpensesList)
    }
    
    public func handleDecrementQuantity(itemId: String, tripMemberId: String) {
            var newTransactionExpensesList = transactionExpensesList

            let index: Int? = transactionExpensesList!.firstIndex(where: {$0.itemId == itemId && $0.tripMemberId == tripMemberId})
            
            if(index != nil) {
                newTransactionExpensesList![index!].quantity! -= 1
            }
            
            transactionExpensesList = newTransactionExpensesList
            
            Logger.debug(transactionExpensesList)
    }
    
    public func getItemExpensesQuantity(itemId: String, tripMemberId: String) -> Int {
        let index: Int? = transactionExpensesList!.firstIndex(where: {$0.itemId == itemId && $0.tripMemberId == tripMemberId})
        
        if(index != nil) {
            return transactionExpensesList![index!].quantity!
        } else {
            return 0
        }
    }
    
    func updateTransaction() {
        if(transaction?.status == "Items") {
            transaction?.status = "Expenses"
        } else if(transaction?.status == "Expenses") {
            transaction?.status = "Done"
        }
        repository.updateTransaction(id: transaction!.id!, transaction: transaction!)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                if(response != nil) {
                    self.transaction = response
                } else {
                    self.state = AppState.Error
                }
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    
    func submitTransactionExpenses() {
        for transactionExpenses in transactionExpensesList! {
            print(transactionExpenses)
            if(transactionExpenses.saved == false) {
                repository.addTransactionExpenses(transactionExpenses: transactionExpenses)
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { response in
                        if(response != nil) {
                            self.successSendCounter += 1
                            if(self.successSendCounter == self.transactionExpensesList!.count) {
                                self.moveToSplitBillView = true
                            }
                        } else {
                            self.state = AppState.Error
                        }
                    }, onError: {error in
                        self.state = AppState.Error
                    }).disposed(by: disposeBag)
            } else {
                repository.updateTransactionExpenses(id: transactionExpenses.id!, transactionExpenses: transactionExpenses)
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { response in
                        if(response != nil) {
                            self.successSendCounter += 1
                            if(self.successSendCounter == self.transactionItemList!.count) {
                                self.moveToSplitBillView = true
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
    
    public func selectUser(tripMemberId: String) {
        selectedUserId = tripMemberId
    }
    
    public func getRemainingQuantity(itemId: String) -> Int{
        var quantity = 0
        
        for transactionItem in transactionItemList! {
            if(transactionItem.id == itemId) {
                quantity += Int(transactionItem.quantity!)
            }
        }
        
        for transactionExpenses in transactionExpensesList! {
            if(transactionExpenses.itemId == itemId) {
                quantity -= transactionExpenses.quantity!
            }
        }
        
        return quantity
    }
    
    public func fetchData(tripId: String, transactionId: String) {
        self.state = AppState.Loading
        fetchTransaction(transactionId: transactionId)
        fetchTripMemberList(tripId: tripId)
        fetchTransactionExpenseList(transactionId: transactionId)
        fetchTransactionItemList(transactionId: transactionId)
        
//        if(transactionItemList == nil) {
//            fetchTransactionItemList(transactionId: transactionId)
//        } else {
//           self.transactionItemList = transactionItemList!
//        }
    }
}
