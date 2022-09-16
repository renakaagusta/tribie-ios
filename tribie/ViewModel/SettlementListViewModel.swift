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
    
    @Published var trip: Trip?
    @Published var tripMemberList: [TripMember]?
    @Published var transactionSettlementList: [TransactionSettlement]?
    @Published var groupedSettlementList: [TransactionSettlement]?
    @Published var itemList: [TransactionItem]?
    
    private var repository: NetworkRepository = NetworkRepository()
    private let disposeBag: DisposeBag =  DisposeBag()
    
    public func fetchTrip(tripId : String) {
        repository.getTripData(tripId: tripId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.trip = response
                self.handleGroupSettlementList()
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func fetchTransactionSettlementList(transactionId : String = AppConstant.DUMMY_DATA_TRANSACTION_ID) {
        repository.getTransactionSettlementList(transactionId: transactionId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.transactionSettlementList = response ?? []
                self.handleGroupSettlementList()
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func fetchTransactionItemList(transactionId : String = AppConstant.DUMMY_DATA_TRANSACTION_ID) {
        repository.getTransactionItemList(transactionId: transactionId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.itemList = response ?? []
                self.handleGroupSettlementList()
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func fetchTripTransactionSettlementList(tripId: String) {
           repository.getTripTransactionSettlementList(tripId: tripId)
               .observe(on: MainScheduler.instance)
               .subscribe(onNext: { response in
                   self.transactionSettlementList = response != nil ? response!.filter({$0.tripId == tripId}) : []
                   self.handleGroupSettlementList()
               }, onError: {error in
                   self.state = AppState.Error
               }).disposed(by: disposeBag)
       }
       
       public func fetchTripTransactionItemList(tripId : String) {
           repository.getTripTransactionItemList(tripId: tripId)
               .observe(on: MainScheduler.instance)
               .subscribe(onNext: { response in
                   self.itemList = response ?? []
                   self.handleGroupSettlementList()
               }, onError: {error in
                   self.state = AppState.Error
               }).disposed(by: disposeBag)
       }
    
    public func fetchTripMemberList(tripId: String) {
        repository.getTripMemberList(tripId: tripId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.tripMemberList = response ?? []
                self.handleGroupSettlementList()
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    func handleGroupSettlementList() {
        if(tripMemberList == nil || transactionSettlementList == nil || itemList == nil) {
            return
        }
        
        if(groupedSettlementList == nil) {
            groupedSettlementList = []
        }
        
        for (index, transactionSettlement) in transactionSettlementList!.enumerated() {
            var sameSettlementIndex =  groupedSettlementList!.firstIndex(where: {$0.userFromId == transactionSettlement.userFromId && $0.userToId == transactionSettlement.userToId})
            var oppsiteSettlementIndex = groupedSettlementList!.firstIndex(where: {$0.userFromId == transactionSettlement.userToId && $0.userToId == transactionSettlement.userFromId})
            if (sameSettlementIndex != nil) {
                Logger.info("------1")
                groupedSettlementList![sameSettlementIndex!].nominal! += transactionSettlement.nominal!
            } else if(oppsiteSettlementIndex != nil) {
                Logger.info("------2")
                if(groupedSettlementList![oppsiteSettlementIndex!].nominal! - transactionSettlement.nominal! > 0) {
                    groupedSettlementList![oppsiteSettlementIndex!].nominal! -= transactionSettlement.nominal!
                } else {
                    groupedSettlementList![oppsiteSettlementIndex!].nominal! = -1 * (groupedSettlementList![oppsiteSettlementIndex!].nominal! - transactionSettlement.nominal!)
                    groupedSettlementList![oppsiteSettlementIndex!].userToId = transactionSettlement.userToId
                    groupedSettlementList![oppsiteSettlementIndex!].userFromId = transactionSettlement.userFromId
                }
            } else {
                Logger.info("------3")
                groupedSettlementList!.append(transactionSettlement)
            }
        }
        
        self.state = AppState.Exist
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
        fetchTrip(tripId: tripId)
    }
    
    public func textLimit(existingText: String?, limit: Int) -> String {
        let text = existingText ?? ""
        
        let isAtLimit = existingText!.count <= limit
        
        return String(isAtLimit)
    }
}
