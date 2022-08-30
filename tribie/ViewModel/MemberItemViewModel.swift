//
//  MemberItemViewModel.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation

struct Trip: Hashable, Codable, Identifiable {
    var id: String?
    var description: String?
    var createdAt: Date?
    var updatedAt: Date?
}

struct TripMember: Hashable, Codable, Identifiable {
    var id: String?
    var tripId: String?
    var userId: String?
    var name: String?
    var createdAt: Date?
    var updatedAt: Date?
}

struct Transaction: Hashable, Codable, Identifiable {
    var id: String?
    var tripId: String? 
    var title: String?
    var description: String?
    var createdAt: Date?
    var updatedAt: Date?
    var userPaidId: String?
}

struct TransactionItem: Hashable, Codable, Identifiable {
    var id: String?
    var title: String?
    var description: String?
    var price: Int?
    var quantity: Int?
    var createdAt: Date?
    var updatedAt: Date?
}

struct TransactionExpenses: Hashable, Codable, Identifiable {
    var id: String?
    var itemId: String?
    var transactionId: String?
    var tripMemberId: String?
    var quantity: Int?
    var createdAt: Date?
    var updatedAt: Date?
}

struct TransactionSettlement: Hashable, Codable, Identifiable {
    var id: String?
    var itemId: String?
    var tripMemberId: String?
    var transactionId: String?
    var nominal: Int?
    var createdAt: Date?
    var updatedAt: Date?
}
