//
//  TransactionSettlement.swift
//  tribie
//
//  Created by renaka agusta on 31/08/22.
//

import Foundation

struct TransactionSettlement: Hashable, Codable, Identifiable {
    var id: String?
    var tripId: String?
    var transactionId: String?
    var userFromId: String?
    var userToId: String?
    var itemId: String?
    var tripMemberId: String?
    var nominal: Int?
    var saved: Bool?
    var createdAt: String?
    var updatedAt: String?
}
