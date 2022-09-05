//
//  SplitBillViewModel.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation
import Combine
import RxSwift

class SplitBillListViewModel: ObservableObject {
    @Published var state: AppState = AppState.Initial
    @Published var transaction: Transaction?
    @Published var transactionExpensesList: [TransactionExpenses]?
    @Published var transactionItemList: [TransactionItem]?
    @Published var tripMemberList: [TripMember]?
    @Published var grandTotal : Int = 0
    @Published var subTotal : Int = 0
    @Published var userPaid : TripMember?
    @Published var increment : Int = 0
    @Published var quantity : [Int] = [0,1]
    
    private var repository: NetworkRepository = NetworkRepository()
    private let disposeBag: DisposeBag =  DisposeBag()
    
    public func fetchTransaction(transactionId: String = AppConstant.DUMMY_DATA_TRANSACTION_ID) {
        repository.getTransactionData(transactionId: transactionId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.transaction = response ?? Transaction()
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func fetchTransactionItemList(transactionId : String = AppConstant.DUMMY_DATA_TRANSACTION_ID){
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
    
    public func fetchTransactionExpensesList(transactionId: String = AppConstant.DUMMY_DATA_TRANSACTION_ID){
        repository.getTransactionExpensesList(transactionId: transactionId)
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
    
    public func getUserPaid() -> TripMember {
        if(transaction != nil && self.tripMemberList!.count > 0) {
            return self.tripMemberList!.first(where: {$0.id == self.transaction?.userPaidId}) ?? TripMember(name: "Renaka")
        } else {
            return  TripMember(name: "-")
        }
    }
    
    public func getGrandTotal() -> Int {
        var grandTotal = 0
        
        for transactionItem in self.transactionItemList! {
            grandTotal = grandTotal + (Int((transactionItem.quantity ?? 0.0) * transactionItem.price!))
        }
        
        return grandTotal
    }
    
    public func getSubTotal() -> Int {
        var subTotal = 0
        
        for transactionItem in self.transactionItemList! {
          subTotal = grandTotal + (Int((transactionItem.quantity ?? 0.0) * transactionItem.price!))
        }
        
        return subTotal
    }
    
    public func getServiceCharge() -> Int {
        var serviceCharge = 0
        
        for transactionItem in self.transactionItemList! {
          serviceCharge = grandTotal + (Int((transactionItem.quantity ?? 0.0) * transactionItem.price!))
        }
        
        return serviceCharge
    }

    public func handleIncrementQuantity(index: Int) {
        var newTransactionItemList = transactionItemList
        if(newTransactionItemList!.count > 0) {
            if(newTransactionItemList![index].quantity == nil) {
                newTransactionItemList![index].quantity = 1
            } else {
                newTransactionItemList![index].quantity! += 1
            }
        }
        
        transactionItemList = newTransactionItemList
    }
    
    public func handleDecrementQuantity(index: Int) {
        var newTransactionItemList = transactionItemList
        if(newTransactionItemList!.count > 0) {
            if(newTransactionItemList![index].quantity == nil || newTransactionItemList![index].quantity == 0) {
                newTransactionItemList![index].quantity = 0
            } else {
                newTransactionItemList![index].quantity! -= 1
            }
        }
        
        transactionItemList = newTransactionItemList
    }
    
    public func addItem() {
        transactionItemList!.append(
            TransactionItem(id: Random.randomString(length: 10), title: "", price: 0, quantity: 0))
    }
    
    public func fetchData(tripId: String, transactionId: String) {
        self.state = AppState.Loading
        fetchTransaction(transactionId: transactionId)
        fetchTransactionItemList(transactionId: transactionId)
        fetchTripMemberList(tripId: tripId)
    }
}
