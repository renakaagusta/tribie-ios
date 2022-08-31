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
