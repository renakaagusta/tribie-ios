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
    var createdAt: String?
    var updatedAt: String?
}
