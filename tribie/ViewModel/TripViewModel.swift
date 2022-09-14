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
    @Published var transactionList: [Transaction]?
    @Published var transactionItemList: [TransactionItem]?
    @Published var tripMemberList: [TripMember]?
    @Published var transactionExpensesList: [TransactionExpenses]?
    @Published var transactionSettlementList: [TransactionSettlement]?
    @Published var successSendCounter = 0
    
    @Published var showSuccessAlert: Bool = false
    @Published var showErrorAlert: Bool = false
    
    private var repository: NetworkRepository = NetworkRepository()
    private let disposeBag: DisposeBag =  DisposeBag()
    
    public func fetchTripTransactionList(tripId: String = AppConstant.DUMMY_DATA_TRIP_ID){
        repository.getTripTransactionList(tripId: tripId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.transactionList = response != nil ? response!.filter({$0.tripId == tripId}) : []
                if (self.transactionList!.count != 0) {
                    self.state = AppState.Exist
                }
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func fetchTransactionItemList(tripId: String = AppConstant.DUMMY_DATA_TRANSACTION_ID){
        repository.getTripTransactionItemList(tripId: tripId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.transactionItemList = response ?? []
                if (self.transactionItemList!.count != 0) {
                    self.state = AppState.Exist
                }
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func fetchTripMemberList(tripId: String = AppConstant.DUMMY_DATA_TRIP_ID) {
        repository.getTripMemberList(tripId: tripId)
            .subscribe(onNext: { response in
                self.tripMemberList = response ?? []
                if (self.tripMemberList!.count != 0) {
                    self.state = AppState.Exist
                }
                
                self.calculateDebtListRank()
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func fetchTransactionExpensesList(tripId: String = AppConstant.DUMMY_DATA_TRANSACTION_ID) {
        repository.getTripTransactionExpensesList(tripId: tripId)
            .subscribe(onNext: { response in
                self.transactionExpensesList = response ?? []
                if (self.transactionExpensesList!.count != 0) {
                    self.state = AppState.Exist
                }
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func fetchTransactionSettlementList(tripId: String = AppConstant.DUMMY_DATA_TRIP_ID){
        repository.getTripTransactionSettlementList(tripId: tripId)
            .subscribe(onNext: { response in
                self.transactionSettlementList = response ?? []
                if (self.transactionSettlementList!.count != 0) {
                    self.state = AppState.Exist
                }
                
                self.calculateDebtListRank()
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func removeTransaction(transactionId: String = AppConstant.DUMMY_DATA_TRANSACTION_ID) {
        repository.deleteTransaction(id: transactionId)
            .subscribe(onNext: { response in
                if (response != nil) {
                    self.showSuccessAlert = true
                } else {
                    self.showErrorAlert = true
                }
                self.resetAlertState()
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    
    
    func resetAlertState() {
        Task {
            sleep(1)
            self.showSuccessAlert = false
            self.showErrorAlert = false
        }
    }
    
    func calculateTotalExpenses() -> Int {
        var totalExpenses: Int = 0
        
        for transaction in transactionList! {
            totalExpenses += transaction.grandTotal!
        }
        
        return totalExpenses
    }
    
    func calculateDebtListRank() {
        if(tripMemberList == nil || transactionSettlementList == nil) {
            return
        }
        
        for (index, _) in tripMemberList!.enumerated() {
            if(tripMemberList![index].expenses == nil) {
                tripMemberList![index].expenses = 0
            }
        }
        
        for (index, transactionSettlement) in transactionSettlementList!.enumerated() {
            let tripMemberIndex = tripMemberList!.firstIndex(where: {$0.id == transactionSettlement.userFromId})!
            
            tripMemberList![tripMemberIndex].expenses! += transactionSettlement.nominal!
        }
        
        tripMemberList = tripMemberList!.sorted(by: {$0.expenses! > $1.expenses!})
    }
    
    func getUserPaid(userPaidId: String) -> TripMember {
        if(tripMemberList!.count > 0){
            return tripMemberList!.first(where: {$0.id == userPaidId})!
        } else {
            return TripMember(name:"-")
        }
    }
    
    func getUserName(tripMemberId: String?) -> String {
        return tripMemberList!.first(where: {$0.id == tripMemberId})!.name ?? "-"
    }
    
    func dateFromString(string: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate] // Added format options
        let date = dateFormatter.date(from: string) ?? Date.now
        let formatter = DateFormatter()
        formatter.dateFormat = "E d MMM"
        return formatter.string(from: date)
    }
    
    func timeFromString(string: String) -> String {
        let timeFormatter = ISO8601DateFormatter()
        timeFormatter.formatOptions = [.withFullDate] // Added format options
        let time = timeFormatter.date(from: string) ?? Date.now
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm"
        return formatter.string(from: time)
    }
    
    
    func getSplitBillState(status: String) -> SplitbillState {
        if(status == "Item") {
            return SplitbillState.InputTransactionItem
        } else if(status == "Expenses") {
            return SplitbillState.Done
        } else if(status == "Calculated") {
            return SplitbillState.Calculate
        }
        return SplitbillState.InputTransactionItem
    }
    
    public func fetchData(tripId: String?) {
        self.state = AppState.Loading
        fetchTripTransactionList(tripId: tripId ?? "")
        fetchTripMemberList(tripId: tripId ?? "")
        fetchTransactionItemList(tripId: tripId ?? "")
        fetchTransactionExpensesList(tripId: tripId ?? "")
        fetchTransactionSettlementList(tripId: tripId ?? "")
    }
}
