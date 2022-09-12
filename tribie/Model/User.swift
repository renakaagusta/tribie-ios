//
//  User.swift
//  macnivision
//
//  Created by Renaka Agusta on 24/06/22.
//

import Foundation

struct User: Hashable, Codable, Identifiable {
    var id: String?
    var name: String?
    var username: String?
    var appleId: String?
    var deviceId: String?
    var email: String?
    var createdAt: String?
    var updatedAt: String?
}
