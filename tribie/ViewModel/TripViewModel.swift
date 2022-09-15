//
//  MemberSpendingViewModel.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation
import RxSwift
import UIKit

struct ShareText: Identifiable {
    let id = UUID()
    let text: String
}

class TripViewModel: ObservableObject {
    @Published var state: AppState = AppState.Initial
    @Published var trip: Trip?
    @Published var transactionList: [Transaction]?
    @Published var transactionItemList: [TransactionItem]?
    @Published var tripMemberList: [TripMember]?
    @Published var transactionExpensesList: [TransactionExpenses]?
    @Published var transactionSettlementList: [TransactionSettlement]?
    @Published var successSendCounter = 0
    
    @Published var showSuccessAlert: Bool = false
    @Published var showErrorAlert: Bool = false
    
    @Published var reportText: String?
    @Published var showReport: Bool?
    
    private var repository: NetworkRepository = NetworkRepository()
    private let disposeBag: DisposeBag =  DisposeBag()
    
    public func fetchTrip(tripId: String = AppConstant.DUMMY_DATA_TRIP_ID) {
        repository.getTripData(tripId: tripId)
            .subscribe(onNext: { response in
                self.trip = response
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
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
    
    
    public func getSplitBillState(status: String) -> SplitbillState {
        if(status == "Item") {
            return SplitbillState.InputTransactionItem
        } else if(status == "Expenses") {
            return SplitbillState.Done
        } else if(status == "Calculated") {
            return SplitbillState.Calculate
        }
        return SplitbillState.InputTransactionItem
    }
    
    public func exportReport() {
        if(trip == nil || transactionList == nil || transactionSettlementList == nil) {
            return
        }
        
        transactionSettlementList = transactionSettlementList!.sorted(by: {$0.userFromId! > $1.userToId!})
        
        var report = ""
        report += trip!.title!
        report += "\n"
        report += "*DD - MM* to *DD - MM*"
        report += "\n"
        report += "\n"
        report += "-----------------\n"
        report += "\n"
        
        report += "[ALL TRANSACTION]"
        report += "\n"
        report += "\n"
        
        for (index, transaction) in transactionList!.enumerated() {
            report += String(index + 1)
            report += ". "
            report += String(transaction.title!)
            report += "\n"
            report += "*Rp"
            report += String(transaction.grandTotal!)
            report += "*\n"
            report += "Paid by _*"
            report += getUserName(tripMemberId: transaction.userPaidId!)
            report += "*_\n"
            report += "\n"
        }
        
        report += "\n"
        report += "-----------------\n"
        
        report += "[SETTLEMENT]"
        report += "\n"
        report += "\n"
        
        for (index, transactionSettlement) in transactionSettlementList!.enumerated() {
            report += getUserName(tripMemberId: transactionSettlement.userFromId)
            report += " ➡️ "
            report += getUserName(tripMemberId: transactionSettlement.userToId)
            report += "\n"
            report += "*Rp"
            report += String(transactionSettlement.nominal!)
            report += "*\n"
            report += "\n"
        }
        
        Logger.debug(report)
        
        reportText = report
       showReport = true
    }
    
    public func fetchData(tripId: String?) {
        self.state = AppState.Loading
        fetchTrip(tripId: tripId ?? "")
        fetchTripTransactionList(tripId: tripId ?? "")
        fetchTripMemberList(tripId: tripId ?? "")
        fetchTransactionItemList(tripId: tripId ?? "")
        fetchTransactionExpensesList(tripId: tripId ?? "")
        fetchTransactionSettlementList(tripId: tripId ?? "")
    }
}


/*
 TRIP NAME
 Date:
 *DD - MM* to *DD - MM*

 ---------

 *Transactions*
 _DD - MM_
 1. Title
 Amount
 Paid by

 2. Title
 Amount
 Paid by

 _DD-MM_
 3. Title
 Amount
 Paid by

 --------

 *Settlements*
 Aron to Winnie
 Rp157.000

 Aron to Winnie
 Rp157.000

 Dipron to Gusron
 Rp392.500*/

