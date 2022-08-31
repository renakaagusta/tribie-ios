//
//  TransactionItem.swift
//  tribie
//
//  Created by renaka agusta on 31/08/22.
//

import Foundation

struct TransactionItem: Hashable, Codable, Identifiable {
    var id: String?
    var title: String?
    var description: String?
    var price: Double?
    var quantity: Double?
    var createdAt: String?
    var updatedAt: String?
}
