//
//  TripMember.swift
//  tribie
//
//  Created by renaka agusta on 31/08/22.
//

import Foundation

struct TripMember: Hashable, Codable, Identifiable {
    var id: String?
    var tripId: String?
    var userId: String?
    var name: String?
    var net: Int? = 0
    var income: Int? = 0
    var expenses: Int? = 0
    var createdAt: String?
    var updatedAt: String?
}
