//
//  SignInResponse.swift
//  tribie
//
//  Created by renaka agusta on 03/09/22.
//

import Foundation

struct SignInResponse: Hashable, Codable {
    var user: User
    var token: String?
    
    struct User: Hashable, Codable, Identifiable {
        var id: String?
        var name: String?
        var username: String?
        var appleId: String?
        var email: String?
        var createdAt: String?
        var updatedAt: String?
    }
}
