//
//  SplitBillViewModel.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation

class SplitBillListViewModel: ObservableObject {
    @Published var state: AppState = AppState.Initial
    @Published var transaction: Transaction?
    @Published var transactionItemList: [TransactionItem] = []
    @Published var grandTotal : Int = 0
    @Published var subTotal : Int = 0
    @Published var userPaid : TripMember?
    
    public func fetchTransaction(){
        do {
            self.transaction = Transaction(
                id: "0",
                title: "Cak Har",
                description: ""
            )
            if (transactionItemList.count != 0) {
                self.state = AppState.Exist
            } else {
                self.state = AppState.Empty
            }
        } catch  let error {
            state = AppState.Error
        }
    }
    
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
    
    public func fetchData() {
        self.state = AppState.Loading
        fetchTransaction()
        fetchTransactionItemList()
    }
}
