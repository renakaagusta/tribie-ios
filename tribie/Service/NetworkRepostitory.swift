//
//  NetworkRepostitory.swift
//  tribie
//
//  Created by renaka agusta on 31/08/22.
//

import RxSwift
import Alamofire
import Foundation

protocol ApiServices {
    func getTripData(tripId: String) -> Observable<Trip?>
    func getTripMemberList(tripId: String) -> Observable<[TripMember]?>
    func getTripTransactionList(tripId: String) -> Observable<[Transaction]?>
    func getTripTransactionItemList(tripId: String) -> Observable<[TransactionItem]?>
    func getTripTransactionExpensesList(tripId: String) -> Observable<[TransactionExpenses]?>
    func getTripTransactionSettlementList(tripId: String) -> Observable<[TransactionSettlement]?>
    func getTransactionData(transactionId: String) -> Observable<[Transaction]?>
    func getTransactionItemList(transactionId: String) -> Observable<[TransactionItem]?>
    func getTransactionExpensesList(transactionId: String) -> Observable<[TransactionExpenses]?>
    func getTransactionSettlementList(transactionId: String) -> Observable<[TransactionSettlement]?>
}

class NetworkRepository : ApiServices {
    
    private let service: NetworkManager
    private let baseUrl: String
    
    init(service: NetworkManager = NetworkManager(), baseUrl: String = "http://203.194.113.105:8080/v1") {
        self.service = service
        self.baseUrl = baseUrl
    }
    
    func getTripData(tripId: String) -> Observable<Trip?> {
        return service.requestGet(urlString: baseUrl + "/trips/\(tripId)")
    }
    
    func getTripMemberList(tripId: String) -> Observable<[TripMember]?> {
        return service.requestGet(urlString: baseUrl + "/trips/\(tripId)/trip-members")
    }
    
    func getTripTransactionList(tripId: String) -> Observable<[Transaction]?> {
        return service.requestGet(urlString: baseUrl + "/trips/\(tripId)/transactions")
    }
    
    func getTripTransactionItemList(tripId: String) -> Observable<[TransactionItem]?> {
        return service.requestGet(urlString: baseUrl + "/trips/\(tripId)/transaction-items")
    }
    
    func getTripTransactionExpensesList(tripId: String) -> Observable<[TransactionExpenses]?> {
        return service.requestGet(urlString: baseUrl + "/trips/\(tripId)/transaction-items")
    }
    
    func getTripTransactionSettlementList(tripId: String) -> Observable<[TransactionSettlement]?> {
        return service.requestGet(urlString: baseUrl + "/trips/\(tripId)/transaction-payments")
    }
    
    func getTransactionData(transactionId: String) -> Observable<[Transaction]?> {
        return service.requestGet(urlString: baseUrl + "/transactions/\(transactionId)")
    }
    
    func getTransactionItemList(transactionId: String) -> Observable<[TransactionItem]?> {
        return service.requestGet(urlString: baseUrl + "/transactions/\(transactionId)/transaction-items")
    }
    
    func getTransactionExpensesList(transactionId: String) -> Observable<[TransactionExpenses]?> {
        return service.requestGet(urlString: baseUrl + "/transactions/\(transactionId)/transaction-expenses")
    }
    
    func getTransactionSettlementList(transactionId: String) -> Observable<[TransactionSettlement]?> {
        return service.requestGet(urlString: baseUrl + "/transaction/\(transactionId)/transaction-payments")
    }
}




