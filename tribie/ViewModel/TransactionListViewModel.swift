//
//  TransactionListViewControlller.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation

class TransactionListViewModel: ObservableObject {
    
    @Published var state: AppState = AppState.Initial
    
    @Published var transactionItemList: [TransactionItem] = []
    @Published var tripMemberList: [TripMember] = []
    @Published var transactionExpensesList: [TransactionExpenses] = []
    @Published var transactionList: [Transaction] = []
    
    public func fetchTransactionList(){
        do {
            self.transactionList = [
                Transaction(id: "0", tripId: "0", title: "Cak Har", description: "uwaw", createdAt: Date(), updatedAt: Date()),
                Transaction(id: "1", tripId: "1", title: "Cak Lur", description: "wowowow", createdAt: Date(), updatedAt: Date()),
                Transaction(id: "2", tripId: "2", title: "Cak Mang", description: "Nice", createdAt: Date(), updatedAt: Date())
            ]
        } catch let error {
            print(error.localizedDescription)
            state = AppState.Error
        }
    }
    
    public func fetchTransactionItemList(){
        do {
             self.transactionItemList = [
                TransactionItem(id: "0",title: "Nasi Putih", price: 10000, quantity: 3),
                TransactionItem(id: "1",title: "Ayam bakar", price: 13000, quantity: 1),
                TransactionItem(id: "2",title: "Susu Putih", price: 11000, quantity: 2)
            ]
            
            if (transactionItemList.count != 0) {
                self.state = AppState.Exist
            } else {
                self.state = AppState.Empty
            }
        } catch let error {
            print(error.localizedDescription)
            state = AppState.Error
        }
    }
    
    public func fetchTripMemberList(){
        do {
            self.tripMemberList = [
                TripMember(id: "0", tripId: "0", userId: "0", name: "Gusde", createdAt: Date(), updatedAt: Date()),
                TripMember(id: "1", tripId: "1", userId: "1", name: "Arnold", createdAt: Date(), updatedAt: Date()),
                TripMember(id: "2", tripId: "2", userId: "2", name: "Winnie", createdAt: Date(), updatedAt: Date()),
            ]
            if (transactionItemList.count != 0) {
                self.state = AppState.Exist
            } else {
                self.state = AppState.Empty
            }
        } catch  let error {
            print(error.localizedDescription)
            state = AppState.Error
        }
    }
    
    public func fetchTransactionExpensesList(){
        do {
            self.transactionExpensesList = [
                TransactionExpenses(id: "0", itemId: "0", tripMemberId: "0", transactionId: "0", quantity: 2, createdAt: Date(), updatedAt: Date()),
                TransactionExpenses(id: "1", itemId: "1", tripMemberId: "1", transactionId: "1", quantity: 4, createdAt: Date(), updatedAt: Date()),
                TransactionExpenses(id: "2", itemId: "2", tripMemberId: "2", transactionId: "3", quantity: 5, createdAt: Date(), updatedAt: Date()),
            ]
            if (transactionItemList.count != 0) {
                self.state = AppState.Exist
            } else {
                self.state = AppState.Empty
            }
        } catch let error {
            print(error.localizedDescription)
            state = AppState.Error
        }
    }
    
    public func fetchData() {
        self.state = AppState.Loading
        fetchTripMemberList()
        fetchTransactionItemList()
        fetchTransactionExpensesList()
        fetchTransactionList()
    }
    
    public func getTotalTransactionExpenses(transactionId: String) -> Int {
        var totalExpenses: Int = 0

        for tripExpenses in transactionExpensesList {
            if tripExpenses.transactionId == transactionId {
                totalExpenses += tripExpenses.quantity! * transactionItemList.first(where: {$0.id == tripExpenses.itemId})!.price!
            }
        }

        return totalExpenses
    }
    
    public func getTripMemberTransaction(tripId: String) -> String {
        var memberName: String = ""
        
        for tripMemberTransaction in tripMemberList {
            if tripMemberTransaction.tripId == tripId {
                memberName = tripMemberTransaction.name ?? ""
            }
        }
        return memberName
    }
    
//    public func getDateTransaction() {
//        let date = Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy"
//        dateFormatter.dateFormat = "mm"
//        let yearString = dateFormatter.string(from: date)
//        let monthString = dateFormatter.s
//    }
    
}
