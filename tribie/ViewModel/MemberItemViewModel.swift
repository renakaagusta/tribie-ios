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
    @Published var transactionItemList: [TransactionItem] = []
    @Published var tripMemberList : [TripMember] = []
    @Published var transactionExpenseList : [TransactionExpenses] = []
    @Published var selectedUserId: String?
    
    private var repository: NetworkRepository = NetworkRepository()
    private let disposeBag: DisposeBag =  DisposeBag()
    
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
        } catch let error {
            state = AppState.Error
        }
    }
    
    public func fetchTripMemberList(){
        do {
            repository.getTripMemberList(tripId: AppConstant.DUMMY_DATA_TRIP_ID)
                .observe(on: MainScheduler.instance)
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
    
    public func fetchTransactionExpenseList(){
        do {
            repository.getTransactionExpensesList(transactionId:
                                                    AppConstant.DUMMY_DATA_TRANSACTION_ID)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { response in
                    self.transactionExpenseList = response!
                    if (self.transactionExpenseList.count != 0) {
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
        fetchTripMemberList()
        fetchTransactionItemList()
        fetchTransactionExpenseList()
    }
}
