//
//  TransactionSettlement.swift
//  tribie
//
//  Created by renaka agusta on 31/08/22.
//

import Foundation

struct TransactionSettlement: Hashable, Codable, Identifiable {
    var id: String?
    var itemId: String?
    var tripMemberId: String?
    var transactionId: String?
    var nominal: Int?
    var createdAt: String?
    var updatedAt: String?
}
