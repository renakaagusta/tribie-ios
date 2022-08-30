//
//  SettlementListViewController.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation

class SettlementListViewModel: ObservableObject {
    
    @Published var state: AppState = AppState.Initial
    
    @Published var tripMemberList: [TripMember] = []
    @Published var transactionSettlementList: [TransactionSettlement] = []
    @Published var transactionItemList: [TransactionItem] = []
    
    
    public func fetchTransactionSettlementList() {
        do {
            self.transactionSettlementList = [
                TransactionSettlement(id: "0", itemId: "0", tripMemberId: "0", transactionId: "0", nominal: 201003, createdAt: Date(), updatedAt: Date()),
                TransactionSettlement(id: "1", itemId: "1", tripMemberId: "1", transactionId: "1", nominal: 401003, createdAt: Date(), updatedAt: Date()),
                TransactionSettlement(id: "2", itemId: "2", tripMemberId: "2", transactionId: "2", nominal: 301003, createdAt: Date(), updatedAt: Date()),
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
    
    public func fetchData() {
        self.state = AppState.Loading
        fetchTripMemberList()
        fetchTransactionSettlementList()
    }
    
}
