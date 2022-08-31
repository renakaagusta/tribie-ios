//
//  Transaction.swift
//  tribie
//
//  Created by renaka agusta on 31/08/22.
//

import Foundation

struct Transaction: Hashable, Codable, Identifiable {
    var id: String?
    var tripId: String?
    var transactionId: String?
    var userPaidId: String?
    var title: String?
    var description: String?
    var createdAt: String?
    var updatedAt: String?
}
