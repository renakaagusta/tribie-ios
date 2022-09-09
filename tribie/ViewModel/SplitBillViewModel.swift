//
//  SplitBillViewModel.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation
import Combine
import RxSwift

enum SplitbillState {
    case InputTransaction
    case InputTransactionItem
    case Calculate
    case Done
}

class SplitBillListViewModel: ObservableObject {
    @Published var state: AppState = AppState.Initial
    @Published var transaction: Transaction?
    @Published var transactionItemList: [TransactionItem]?
    @Published var transactionExpensesList: [TransactionExpenses]?
    @Published var transactionSettlementList: [TransactionSettlement]?
    @Published var tripMemberList: [TripMember]?
    @Published var grandTotal : Int = 0
    @Published var subTotal : Int = 0
    @Published var userPaid : TripMember?
    @Published var increment : Int = 0
    @Published var quantity : [Int] = [0,1]
    @Published var selectedUserId: String?
    @Published var formState: SplitbillState = SplitbillState.InputTransaction
    @Published var successSendCounter = 0
    @Published var successRemoveCounter = 0
    @Published var moveToMemberItemView = false
    @Published var moveToSettlementListView = false
    
    private var minTripMember: TripMember = TripMember()
    private var maxTripMember: TripMember = TripMember()
    
    private var repository: NetworkRepository = NetworkRepository()
    private let disposeBag: DisposeBag =  DisposeBag()
    
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
    
    public func fetchTransactionItemList(transactionId : String = AppConstant.DUMMY_DATA_TRANSACTION_ID){
        repository.getTransactionItemList(transactionId: transactionId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.transactionItemList = response ?? []
                for (index, _) in self.transactionItemList!.enumerated() {
                    self.transactionItemList![index].saved = true
                }
                if (self.transactionItemList!.count != 0) {
                    self.state = AppState.Exist
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
                }
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func fetchTransactionSettlementList(transactionId : String = AppConstant.DUMMY_DATA_TRANSACTION_ID){
        repository.getTransactionSettlementList(transactionId: transactionId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.transactionSettlementList = response ?? []
                for (index, _) in self.transactionSettlementList!.enumerated() {
                    self.transactionSettlementList![index].saved = true
                }
                if (self.transactionSettlementList!.count != 0) {
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
                self.tripMemberList = response ?? []
                if (self.tripMemberList!.count != 0) {
                    self.state = AppState.Exist
                }
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    func findMinimumTripMemberNetto() ->  TripMember {
        var minTripMember = self.tripMemberList![0]
        
        for tripMember in tripMemberList! {
            if(tripMember.net! < minTripMember.net!) {
                minTripMember = tripMember
            }
        }
        
        return minTripMember
    }
        
    func findMaximumTripMemberNetto() -> TripMember{
        var maxTripMember = self.tripMemberList![0]
        
        for tripMember in tripMemberList! {
            if(tripMember.net! > maxTripMember.net!) {
                maxTripMember = tripMember
            }
        }
    
        return maxTripMember
    }
    
    func submitTransaction() {
        transaction?.userPaidId = selectedUserId
        transaction?.status = "Created"
        transaction?.method = "Item"
        repository.addTransaction(transaction: transaction!)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                if(response != nil) {
                    self.transaction = response
                    
                    self.formState = SplitbillState.InputTransactionItem
                } else {
                    self.state = AppState.Error
                }
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    func removeAllTransactionSettlement() {
        for transactionSettlement in transactionSettlementList! {
            if(transactionSettlement.id != nil) {
                repository.deleteTransactionSettlement(id: transactionSettlement.id!)
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { response in
                        self.successRemoveCounter += 1
                        if(self.successRemoveCounter == self.transactionSettlementList!.count) {
                            self.transactionSettlementList = []
                            self.calculateSplitBill()
                        }
                    }, onError: {error in
                        self.state = AppState.Error
                    }).disposed(by: disposeBag)
            } else {
                self.successRemoveCounter += 1
                if(self.successRemoveCounter == self.transactionSettlementList!.count) {
                    self.calculateSplitBill()
                }
            }
        }
    }
    
    func handleMoveToMemberItem() {
        if(self.transactionSettlementList != nil) {
          if(self.successRemoveCounter == self.transactionSettlementList!.count) {
                    calculateSplitBill()
                }

            if(self.successSendCounter == self.transactionItemList!.count) {
                self.moveToMemberItemView = true
                self.resetMoveState()
            }
        } else {
            if(self.successSendCounter == self.transactionItemList!.count) {
                self.moveToMemberItemView = true
                self.resetMoveState()
            }
        }
        
    }
    
    func setSplitBillMethod(method: String) {
        self.transaction!.method = method
    }
    
    func updateTransaction(revised: Bool = false) {
        transaction?.grandTotal = getGrandTotal()
        transaction?.subTotal = getSubTotal()
        transaction?.serviceCharge = getServiceCharge()
        if(transaction?.status == "Created") {
            transaction?.status = "Items"
        } else if(transaction?.status == "Item") {
            transaction?.status = "Calculated"
        } else if(transaction?.status == "Calculated") {
            transaction?.status = "Item"
        }
        repository.updateTransaction(id: transaction!.id!, transaction: transaction!)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                if(response != nil) {
                    self.transaction = response
                    if(self.transaction?.status == "Calculated") {
                        self.formState = SplitbillState.Calculate
                    }
                } else {
                    self.state = AppState.Error
                }
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    func submitTransactionItem() {
        for transactionItem in transactionItemList! {
            if(transactionItem.saved == false) {
                repository.addTransactionItem(transactionItem: transactionItem)
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { response in
                        if(response != nil) {
                            self.successSendCounter += 1
                            self.handleMoveToMemberItem()
                        } else {
                            self.state = AppState.Error
                        }
                    }, onError: {error in
                        self.state = AppState.Error
                    }).disposed(by: disposeBag)
            } else {
                repository.updateTransactionItem(id: transactionItem.id!, transactionItem: transactionItem)
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { response in
                        if(response != nil) {
                            self.successSendCounter += 1
                            self.handleMoveToMemberItem()
                        } else {
                            self.state = AppState.Error
                        }
                    }, onError: {error in
                        self.state = AppState.Error
                    }).disposed(by: disposeBag)
            }
        }
    }
    
    func submitTransactionSettlement() {        Logger.info("===============CALCULATION LIST===========")
        for transactionSettlement in transactionSettlementList! {
            Logger.debug(transactionSettlement)
            if(transactionSettlement.saved == false) {
                repository.addTransactionSettlement(transactionSettlement: transactionSettlement)
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { response in
                        if(response != nil) {
                            self.successSendCounter += 1
                            if(self.successSendCounter == self.transactionSettlementList!.count) {
                                self.moveToSettlementListView = true
                                self.resetMoveState()
                            }
                        } else {
                            self.state = AppState.Error
                        }
                    }, onError: {error in
                        self.state = AppState.Error
                    }).disposed(by: disposeBag)
            } else {
                repository.updateTransactionSettlement(id: transactionSettlement.id!, transactionSettlement: transactionSettlement)
                        .observe(on: MainScheduler.instance)
                        .subscribe(onNext: { response in
                            if(response != nil) {
                                self.successSendCounter += 1
                                if(self.successSendCounter == self.transactionSettlementList!.count) {
                                    self.moveToSettlementListView = true
                                    self.resetMoveState()
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
    
    func removeTransactionSettlement() {
        if(transaction?.status != "Items") {
            return
        }
        
        for transactionSettlement in transactionSettlementList! {
            if(transactionSettlement.saved == false) {
                repository.addTransactionSettlement(transactionSettlement: transactionSettlement)
                    .observe(on: MainScheduler.instance)
                    .subscribe(onNext: { response in
                        if(response != nil) {
                            self.successSendCounter += 1
                            if(self.successSendCounter == self.transactionSettlementList!.count) {
                                self.moveToSettlementListView = true
                                self.resetMoveState()
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
    
    func calculateSplitBill() {
        Logger.error("=====CALCULATE NETTO======")
        switch transaction!.method! {
            case "Item":
            calculateSplitBillByItems()
            case "Equally":
            calculateSplitBillEqually()
            case "Manual":
            calculateSplitBillManually()
            default:
            calculateSplitBillByItems()
        }
    }
    
    func calculateSplitBillEqually() {
        
    }
    
    func calculateSplitBillManually() {
        
    }
    
    func calculateSplitBillByItems() {
        for (index, tripMember) in tripMemberList!.enumerated() {
            tripMemberList![index].expenses = 0
            for (indexTransactionExpenses, transactionExpenses) in transactionExpensesList!.filter({$0.tripMemberId == tripMember.id!}).enumerated() {
                let calculateExpenses: Int = transactionExpenses.quantity! * Int(transactionItemList!.first(where: {$0.id == transactionExpenses.itemId})!.price!)
                tripMemberList![index].expenses! += calculateExpenses
            }
            if(tripMember.id == transaction!.userPaidId!) {
                Logger.info("=======WHO PAID==========")
                Logger.info(tripMember.name)
                tripMemberList![index].income = transaction!.grandTotal!
            } else {
                tripMemberList![index].income = 0
            }
            tripMemberList![index].net = tripMemberList![index].income! - tripMemberList![index].expenses!
        }
        
        var counter = 0
        
        Logger.error("======LIST EXPENSES======")
        for transactionExpenses in transactionExpensesList! {
            Logger.error(tripMemberList!.first(where: {$0.id == transactionExpenses.tripMemberId})!.name)
            Logger.error(transactionExpenses.quantity! * Int(transactionItemList!.first(where: {$0.id == transactionExpenses.itemId})!.price!))
        }
        Logger.error("============")

        Logger.error("======CALCULATE NETO======")
        
        for tripMember in tripMemberList! {
            Logger.error(tripMember.name)
            Logger.error(tripMember.net)
            Logger.error(tripMember.income)
            Logger.error(tripMember.expenses)
        }
        Logger.error("============")
        
        Logger.debug("========LOOPING========")
        
        while true {
            let minTripMember = findMinimumTripMemberNetto()
            let minTripMemberIndex = tripMemberList!.firstIndex(where: {$0.id == minTripMember.id})!
            let maxTripMember = findMaximumTripMemberNetto()
            let maxTripMemberIndex = tripMemberList!.firstIndex(where: {$0.id == maxTripMember.id})!
            
            tripMemberList![maxTripMemberIndex].net!+=tripMemberList![minTripMemberIndex].net!
                    
            transactionSettlementList!.append(TransactionSettlement(tripId: transaction!.tripId!, transactionId: transaction!.id!, userFromId: tripMemberList![minTripMemberIndex].id, userToId: tripMemberList![maxTripMemberIndex].id, nominal: tripMemberList![minTripMemberIndex].net! * -1,
                                                                    saved: false, status: "Created"))
            
            Logger.debug(minTripMember.name)
            Logger.debug(maxTripMember.name)
            Logger.debug(tripMemberList![minTripMemberIndex].net! * -1)
                    
            tripMemberList![minTripMemberIndex].net = 0
                
            var isFinish = true
            
            for tripMember in tripMemberList! {
                if(tripMember.net! < 0) {
                    isFinish = false
                }
            }
            
            if(isFinish) {
                break
            }
            
            if(counter > 10) {
                break
            }
            counter+=1
        }
        
        Logger.debug("================")
        
        submitTransactionSettlement()
    }
    
    func resetMoveState() {
        Task {
            sleep(1)
            self.moveToMemberItemView = false
            self.moveToSettlementListView = false
        }
    }
    
    public func getUserPaid() -> TripMember {
        if(transaction != nil && self.tripMemberList!.count > 0) {
            return self.tripMemberList!.first(where: {$0.id == self.transaction?.userPaidId}) ?? TripMember(name: "Renaka")
        } else {
            return  TripMember(name: "-")
        }
    }
    
    public func getGrandTotal() -> Int {
        return transaction?.grandTotal ?? 0
    }
    
    public func getSubTotal() -> Int {
        var subTotal = 0
        
        for transactionItem in self.transactionItemList! {
          subTotal = subTotal + (Int((transactionItem.quantity ?? 0.0) * transactionItem.price!))
        }
        
        return subTotal
    }
    
    public func getServiceCharge() -> Int {
        return getGrandTotal() - getSubTotal()
    }
    
    public func selectUserPay(index: Int) {
        var netTransaction = transaction
        netTransaction!.userPaidId = tripMemberList![index].id!
        transaction = netTransaction
    }
    
    public func selectUser(tripMemberId: String) {
        selectedUserId = tripMemberId
    }

    public func handleIncrementQuantity(index: Int) {
        Logger.debug("---")
        if(getGrandTotal() < getSubTotal()) {
            return
        }
        
        Logger.debug("oops")
        
        var newTransactionItemList = transactionItemList
        if(newTransactionItemList!.count > 0) {
            if(newTransactionItemList![index].quantity == nil) {
                newTransactionItemList![index].quantity = 1
            } else {
                newTransactionItemList![index].quantity! += 1
            }
        }
        
        newTransactionItemList![index].changed = true
        
        transactionItemList = newTransactionItemList
    }
    
    public func handleDecrementQuantity(index: Int) {
        var newTransactionItemList = transactionItemList
        if(newTransactionItemList!.count > 0) {
            if(newTransactionItemList![index].quantity == nil || newTransactionItemList![index].quantity == 0) {
//                newTransactionItemList!.remove(at: index)
            } else {
                newTransactionItemList![index].quantity! -= 1
                newTransactionItemList![index].changed = true
            }
        }
        
        transactionItemList = newTransactionItemList
    }
    
    public func addItem() {
        transactionItemList!.append(
            TransactionItem(id: Random.randomString(length: 10), tripId: transaction!.tripId!, transactionId: transaction!.id!,  title: "", price: 0, quantity: 0, saved: false))
    }
    
    public func handleSelectItemExpenses(tripMemberId: String) {
        if(self.transactionExpensesList!.first(where: {$0.tripMemberId == tripMemberId}) == nil) {
            transactionExpensesList!.append(TransactionExpenses(
                tripMemberId: tripMemberId, tripId: transaction!.tripId,
                transactionId: transaction!.id,
                saved: false, nominal: 0
            ))
            
            splitEqually()
        } else {
            self.transactionExpensesList = self.transactionExpensesList!.filter({$0.tripMemberId != tripMemberId})
            
            splitEqually()
        }
    }
    
    public func splitEqually() {
        for (index, _) in transactionExpensesList!.enumerated() {
            transactionExpensesList![index].nominal = transaction!.grandTotal! / transactionExpensesList!.count
        }
    }
    
    public func fetchData(tripId: String, transactionId: String?, formState: SplitbillState) {
        self.state = AppState.Loading
        self.formState = formState
        fetchTripMemberList(tripId: tripId)
        if(transactionId != nil) {
            fetchTransaction(transactionId: transactionId!)
            fetchTransactionItemList(transactionId: transactionId!)
            fetchTransactionExpensesList(transactionId: transactionId!)
            fetchTransactionSettlementList(transactionId: transactionId!)
        } else {
            fetchTripMemberList(tripId: tripId)
            transactionItemList = [
                
            ]
            self.transaction = Transaction(
                tripId: tripId,
                title: "",
                description: ""
            )
        }
    }
}
