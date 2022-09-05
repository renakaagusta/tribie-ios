//
//  SignInRequest.swift
//  tribie
//
//  Created by renaka agusta on 03/09/22.
//

import Foundation

struct SignInRequest: Hashable, Codable {
    var email: String?
    var password: String?
    var appleId: String?
    var deviceId: String?
}
