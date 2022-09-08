//
//  SettlementListViewModel.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation
import RxSwift

class SettlementListViewModel: ObservableObject {
    
    @Published var state: AppState = AppState.Initial
    
    @Published var tripMemberList: [TripMember]?
    @Published var transactionSettlementList: [TransactionSettlement]?
    @Published var itemList: [TransactionItem]?
    
    private var repository: NetworkRepository = NetworkRepository()
    private let disposeBag: DisposeBag =  DisposeBag()
    
    public func fetchTransactionSettlementList(transactionId : String = AppConstant.DUMMY_DATA_TRANSACTION_ID) {
        repository.getTransactionSettlementList(transactionId: transactionId)
            .observe(on: MainScheduler.instance)
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
    
    public func fetchTransactionItemList(transactionId : String = AppConstant.DUMMY_DATA_TRANSACTION_ID) {
        repository.getTransactionItemList(transactionId: transactionId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.itemList = response ?? []
                if (self.itemList!.count != 0) {
                    self.state = AppState.Exist
                } else {
                    self.state = AppState.Empty
                }
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func fetchTripTransactionSettlementList(tripId : String = AppConstant.DUMMY_DATA_TRIP_ID) {
           repository.getTripTransactionSettlementList(tripId: tripId)
               .observe(on: MainScheduler.instance)
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
       
       public func fetchTripTransactionItemList(tripId : String = AppConstant.DUMMY_DATA_TRIP_ID) {
           repository.getTripTransactionItemList(tripId: tripId)
               .observe(on: MainScheduler.instance)
               .subscribe(onNext: { response in
                   self.itemList = response ?? []
                   if (self.itemList!.count != 0) {
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
    
    func getUserName(tripMemberId: String) -> String {
        return tripMemberList!.first(where: {$0.id == tripMemberId})!.name ?? "-"
    }
    
    public func fetchData(tripId: String, transactionId: String?) {
        self.state = AppState.Loading
        fetchTripMemberList(tripId: tripId)
        if(transactionId != nil) {
            fetchTransactionSettlementList(transactionId: transactionId!)
            fetchTransactionItemList(transactionId: transactionId!)
        } else {
            fetchTripTransactionSettlementList(tripId: tripId)
            fetchTripTransactionItemList(tripId: tripId)
        }
    }
    
    //Text limit
    public func textLimit(existingText: String?, limit: Int) -> String {
        let text = existingText ?? ""
        
        let isAtLimit = existingText!.count <= limit
        
        return String(isAtLimit)
    }
}
