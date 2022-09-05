//
//  SplitBillViewModel.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation
import Combine
import RxSwift

class TransactionFormViewModel: ObservableObject {
    @Published var state: AppState = AppState.Initial
    @Published var transaction: Transaction?
    
    private var repository: NetworkRepository = NetworkRepository()
    private let disposeBag: DisposeBag =  DisposeBag()
    
    public func fetchTransaction(transactionId: String = AppConstant.DUMMY_DATA_TRANSACTION_ID) async {
        repository.getTransactionData(transactionId: transactionId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.transaction = response ?? Transaction()
                self.state = AppState.Exist
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func addTransaction() async {
        self.state = AppState.Loading
        repository.addTransaction(transaction: transaction!)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.transaction = response ?? Transaction()
                self.state = AppState.Finish
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func updateTransaction(transactionId: String = AppConstant.DUMMY_DATA_TRANSACTION_ID) async {
        state = AppState.Loading
        repository.updateTransaction(id: transactionId, transaction: transaction!)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { response in
                self.transaction = response ?? Transaction()
                self.state = AppState.Finish
            }, onError: {error in
                self.state = AppState.Error
            }).disposed(by: disposeBag)
    }
    
    public func fetchData() async {
        self.state = AppState.Loading
        await fetchTransaction()
    }
}
