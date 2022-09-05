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
    @Published var transactionItemList: [TransactionItem]?
    @Published var tripMemberList : [TripMember]?
    @Published var transactionExpensesList : [TransactionExpenses]?
    @Published var selectedUserId: String?
    
    private var repository: NetworkRepository = NetworkRepository()
    private let disposeBag: DisposeBag =  DisposeBag()
    
    public func fetchTransactionItemList(transactionId: String = AppConstant.DUMMY_DATA_TRANSACTION_ID ){
        repository.getTransactionItemList(transactionId: transactionId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.transactionItemList = response!
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
                self.tripMemberList = response! ?? []
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
    
    public func fetchTransactionExpenseList(transactionId: String = AppConstant.DUMMY_DATA_TRANSACTION_ID){
        repository.getTransactionExpensesList(transactionId: transactionId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.transactionExpensesList = response!
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
        var newTransactionExpensesList = transactionExpensesList
        
        let index: Int? = transactionExpensesList!.firstIndex(where: {$0.itemId == itemId && $0.tripMemberId == tripMemberId})
        
        if(index == nil) {
            newTransactionExpensesList?.append(TransactionExpenses(
                itemId: itemId,
                tripMemberId: tripMemberId,
                quantity: 0
            ))
        } else {
            newTransactionExpensesList![index!].quantity! += 1
        }
        
        transactionExpensesList = newTransactionExpensesList
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
    
    public func getItemExpensesQuantity(itemId: String, tripMemberId: String) -> Int {
        let index: Int? = transactionExpensesList!.firstIndex(where: {$0.itemId == itemId && $0.tripMemberId == tripMemberId})
        
        if(index != nil) {
            return transactionExpensesList![index!].quantity!
        } else {
            return 0
        }
    }
    
    public func selectUser(tripMemberId: String) {
        selectedUserId = tripMemberId
    }
    
    public func fetchData(tripId: String, transactionId: String) {
        self.state = AppState.Loading
        fetchTripMemberList(tripId: tripId)
        fetchTransactionItemList(transactionId: transactionId)
        fetchTransactionExpenseList(transactionId: transactionId)
    }
}
