//
//  User.swift
//  macnivision
//
//  Created by Renaka Agusta on 24/06/22.
//

import Foundation

struct User: Hashable, Codable, Identifiable{
    var id: Int
    var recordId: String
    var appleUserId: String = ""
    var deviceId: String = ""
    var name: String = ""
    var email: String = ""
}
