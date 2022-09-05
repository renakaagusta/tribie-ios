//
//  Trip.swift
//  tribie
//
//  Created by renaka agusta on 31/08/22.
//

import Foundation

struct Trip: Hashable, Codable, Identifiable {
    var id: String?
    var title: String? 
    var description: String?
    var createdAt: String?
    var updatedAt: String?
}
