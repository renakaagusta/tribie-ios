//
//  TransactionExpenses.swift
//  tribie
//
//  Created by renaka agusta on 31/08/22.
//

import Foundation

struct TransactionExpenses: Hashable, Codable, Identifiable {
    var id: String?
    var itemId: String?
    var tripMemberId: String?
    var tripId: String?
    var transactionId: String?
    var saved: Bool? = false
    var quantity: Int? = 0
    var createdAt: String?
    var updatedAt: String?
}
