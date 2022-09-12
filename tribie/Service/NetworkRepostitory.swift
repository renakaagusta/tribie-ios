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
    func signIn(request: SignInRequest) -> Observable<SignInResponse?>
    func signInWithApple(request: SignInRequest) -> Observable<SignInResponse?>
    func signInWithDevice(request: SignInRequest) -> Observable<SignInResponse?>
    func signUp(request: User) -> Observable<User?>
    func getUserList() -> Observable<[User]?>
    func getTripList() -> Observable<[Trip]?>
    func getTripData(tripId: String) -> Observable<Trip?>
    func getAllTripMemberList() -> Observable<[TripMember]?>
    func getTripMemberList(tripId: String) -> Observable<[TripMember]?>
    func getTripTransactionList(tripId: String) -> Observable<[Transaction]?>
    func getTripTransactionItemList(tripId: String) -> Observable<[TransactionItem]?>
    func getTripTransactionExpensesList(tripId: String) -> Observable<[TransactionExpenses]?>
    func getTripTransactionSettlementList(tripId: String) -> Observable<[TransactionSettlement]?>
    func getTransactionData(transactionId: String) -> Observable<Transaction?>
    func getTransactionList() -> Observable<[Transaction]?>
    func getTransactionItemList(transactionId: String) -> Observable<[TransactionItem]?>
    func getTransactionExpensesList(transactionId: String) -> Observable<[TransactionExpenses]?>
    func getTransactionSettlementList(transactionId: String) -> Observable<[TransactionSettlement]?>
    func addTrip(trip: Trip) -> Observable<Trip?>
    func addTripMember(tripMember: TripMember) -> Observable<TripMember?>
    func addTransaction(transaction: Transaction) -> Observable<Transaction?>
    func addTransactionItem(transactionItem: TransactionItem) -> Observable<TransactionItem?>
    func addTransactionExpenses(transactionExpenses: TransactionExpenses) -> Observable<TransactionExpenses?>
    func addTransactionSettlement(transactionSettlement: TransactionSettlement) -> Observable<TransactionSettlement?>
    func updateTrip(id: String, trip: Trip) -> Observable<Trip?>
    func updateTripMember(id: String, tripMember: TripMember) -> Observable<TripMember?>
    func updateTransaction(id: String, transaction: Transaction) -> Observable<Transaction?>
    func updateTransactionItem(id: String, transactionItem: TransactionItem) -> Observable<TransactionItem?>
    func updateTransactionExpenses(id: String, transactionExpenses: TransactionExpenses) -> Observable<TransactionExpenses?>
    func updateTransactionSettlement(id: String, transactionSettlement: TransactionSettlement) -> Observable<TransactionSettlement?>
    func deleteTrip(id: String) -> Observable<Trip?>
    func deleteTripMember(id: String) -> Observable<TripMember?>
    func deleteTransaction(id: String) -> Observable<Transaction?>
    func deleteTransactionItem(id: String) -> Observable<TransactionItem?>
    func deleteTransactionExpenses(id: String) -> Observable<TransactionExpenses?>
    func deleteTransactionSettlement(id: String) -> Observable<TransactionSettlement?>
}

class NetworkRepository : ApiServices {
    private let service: NetworkManager
    private let baseUrl: String
    
    init(service: NetworkManager = NetworkManager(), baseUrl: String = "http://203.194.113.105:8080/v1") {
        self.service = service
        self.baseUrl = baseUrl
    }
    
    func signIn(request: SignInRequest) -> Observable<SignInResponse?> {
        return service.requestPost(urlString: baseUrl + "/login", parameters: request, encoding: URLEncoding.default)
    }
    
    func signInWithApple(request: SignInRequest) -> Observable<SignInResponse?> {
        return service.requestPost(urlString: baseUrl + "/login/apple", parameters: request, encoding: URLEncoding.default)
    }

    func signInWithDevice(request: SignInRequest) -> Observable<SignInResponse?> {
        return service.requestPost(urlString: baseUrl + "/login/device", parameters: request, encoding: URLEncoding.default)
    }

    func signUp(request: User) -> Observable<User?> {
        return service.requestPost(urlString: baseUrl + "/register", parameters: request, encoding: URLEncoding.default)
    }
    
    func getTripList() -> Observable<[Trip]?> {
        return service.requestGet(urlString: baseUrl + "/trips")
    }
    
    func getUserList() -> Observable<[User]?> {
        return service.requestGet(urlString: baseUrl + "/users")
    }
    
    func getTripData(tripId: String) -> Observable<Trip?> {
        return service.requestGet(urlString: baseUrl + "/trips/\(tripId)")
    }
    
    func getAllTripMemberList() -> Observable<[TripMember]?> {
        return service.requestGet(urlString: baseUrl + "/trip-members")
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
        return service.requestGet(urlString: baseUrl + "/trips/\(tripId)/transaction-expenses")
    }
    
    func getTripTransactionSettlementList(tripId: String) -> Observable<[TransactionSettlement]?> {
        return service.requestGet(urlString: baseUrl + "/trips/\(tripId)/transaction-payments")
    }
    
    func getTransactionData(transactionId: String) -> Observable<Transaction?> {
        return service.requestGet(urlString: baseUrl + "/transactions/\(transactionId)")
    }
    
    func getTransactionList() -> Observable<[Transaction]?> {
        return service.requestGet(urlString: baseUrl + "/transactions")
    }
    
    func getTransactionItemList(transactionId: String) -> Observable<[TransactionItem]?> {
        return service.requestGet(urlString: baseUrl + "/transactions/\(transactionId)/transaction-items")
    }
    
    func getTransactionExpensesList(transactionId: String) -> Observable<[TransactionExpenses]?> {
        return service.requestGet(urlString: baseUrl + "/transactions/\(transactionId)/transaction-expenses")
    }
    
    func getTransactionSettlementList(transactionId: String) -> Observable<[TransactionSettlement]?> {
        return service.requestGet(urlString: baseUrl + "/transactions/\(transactionId)/transaction-payments")
    }
    
    func addTrip(trip: Trip) -> Observable<Trip?> {
        return service.requestPost(urlString: baseUrl + "/trips", parameters: trip, encoding: URLEncoding.default)
    }
    
    func addTripMember(tripMember: TripMember) -> Observable<TripMember?> {
        return service.requestPost(urlString: baseUrl + "/trip-members", parameters: tripMember, encoding: URLEncoding.default)
    }
    
    func addTransaction(transaction: Transaction) -> Observable<Transaction?> {
        return service.requestPost(urlString: baseUrl + "/transactions", parameters: transaction, encoding: URLEncoding.queryString)
    }

    func addTransactionItem(transactionItem: TransactionItem) -> Observable<TransactionItem?> {
        return service.requestPost(urlString: baseUrl + "/transaction-items", parameters: transactionItem, encoding: URLEncoding.default)
    }

    func addTransactionExpenses(transactionExpenses: TransactionExpenses) -> Observable<TransactionExpenses?> {
        return service.requestPost(urlString: baseUrl + "/transaction-expenses", parameters: transactionExpenses, encoding: URLEncoding.default)
    }

    func addTransactionSettlement(transactionSettlement: TransactionSettlement) -> Observable<TransactionSettlement?> {
        return service.requestPost(urlString: baseUrl + "/transaction-payments", parameters: transactionSettlement, encoding: URLEncoding.default)
    }
    
    func updateTrip(id: String, trip: Trip) -> Observable<Trip?> {
        return service.requestPut(urlString: baseUrl + "/trips/\(id)", parameters: trip, encoding: URLEncoding.default)
    }
    
    func updateTripMember(id: String, tripMember: TripMember) -> Observable<TripMember?> {
        return service.requestPut(urlString: baseUrl + "/trip-members/\(id)", parameters: tripMember, encoding: URLEncoding.default)
    }
    
    func updateTransaction(id: String, transaction: Transaction) -> Observable<Transaction?> {
        return service.requestPut(urlString: baseUrl + "/transactions/\(id)", parameters: transaction, encoding: URLEncoding.default)
    }

    func updateTransactionItem(id: String, transactionItem: TransactionItem) -> Observable<TransactionItem?> {
        return service.requestPut(urlString: baseUrl + "/transaction-items/\(id)", parameters: transactionItem, encoding: URLEncoding.default)
    }

    func updateTransactionExpenses(id: String, transactionExpenses: TransactionExpenses) -> Observable<TransactionExpenses?> {
        return service.requestPut(urlString: baseUrl + "/transaction-expenses/\(id)", parameters: transactionExpenses, encoding: URLEncoding.default)
    }

    func updateTransactionSettlement(id: String, transactionSettlement: TransactionSettlement) -> Observable<TransactionSettlement?> {
        return service.requestPut(urlString: baseUrl + "/transaction-payments/\(id)", parameters: transactionSettlement, encoding: URLEncoding.default)
    }
    
    func deleteTrip(id: String) -> Observable<Trip?> {
        return service.requestDelete(urlString: baseUrl + "/trips/\(id)", encoding: URLEncoding.default)
    }
        
    func deleteTripMember(id: String) -> Observable<TripMember?> {
        return service.requestDelete(urlString: baseUrl + "/trip-members/\(id)", encoding: URLEncoding.default)
    }
        
    func deleteTransaction(id: String) -> Observable<Transaction?> {
        return service.requestDelete(urlString: baseUrl + "/transactions/\(id)", encoding: URLEncoding.default)
    }

    func deleteTransactionItem(id: String) -> Observable<TransactionItem?> {
        return service.requestDelete(urlString: baseUrl + "/transaction-items/\(id)", encoding: URLEncoding.default)
    }

    func deleteTransactionExpenses(id: String) -> Observable<TransactionExpenses?> {
        return service.requestDelete(urlString: baseUrl + "/transaction-expenses/\(id)", encoding: URLEncoding.default)
    }

    func deleteTransactionSettlement(id: String) -> Observable<TransactionSettlement?> {
        return service.requestDelete(urlString: baseUrl + "/transaction-payments/\(id)", encoding: URLEncoding.default)
    }
}




