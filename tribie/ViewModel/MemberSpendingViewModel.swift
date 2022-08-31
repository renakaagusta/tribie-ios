//
//  MemberSpendingViewModel.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation

class MemberSpendingListViewModel: ObservableObject {
    @Published var state: AppState = AppState.Initial
    @Published var transactionItemList: [TransactionItem] = []
    @Published var tripMemberList: [TripMember] = []
    @Published var transactionExpensesList: [TransactionExpenses] = []
    
    public func fetchTransactionItemList(){
        do {
            self.transactionItemList = [
                TransactionItem(id: "0",title: "Nasi Putih", price: 10000, quantity: 3),
                TransactionItem(id: "1",title: "Nasi Putih", price: 10000, quantity: 3),
                TransactionItem(id: "2",title: "Nasi Putih", price: 10000, quantity: 3)
            ]
            if (transactionItemList.count != 0) {
                self.state = AppState.Exist
            } else {
                self.state = AppState.Empty
            }
        } catch let error {
            state = AppState.Error
        }
    }
    
    public func fetchTripMemberList(){
        do {
            self.tripMemberList = [
                TripMember(id: "0", tripId: "", userId: "", name: "Kaka"),
                TripMember(id: "1", tripId: "", userId: "", name: "Arnold"),
                TripMember(id: "2", tripId: "", userId: "", name: "Gusde"),
            ]
            if (tripMemberList.count != 0) {
                self.state = AppState.Exist
            } else {
                self.state = AppState.Empty
            }
        } catch  let error {
            state = AppState.Error
        }
    }
    
    public func fetchTransactionExpensesList(){
        do {
            self.transactionExpensesList = [
                TransactionExpenses(id: "0", itemId: "0", tripMemberId: "0", quantity: 1),
                TransactionExpenses(id: "1", itemId: "1", tripMemberId: "1", quantity: 3),
                TransactionExpenses(id: "2", itemId: "2", tripMemberId: "2", quantity: 2),
            ]
            if (transactionExpensesList.count != 0) {
                self.state = AppState.Exist
            } else {
                self.state = AppState.Empty
            }
        } catch  let error {
            state = AppState.Error
        }
    }
    
    public func fetchData() {
        self.state = AppState.Loading
        fetchTripMemberList()
        fetchTransactionItemList()
        fetchTransactionExpensesList()
    }
}
