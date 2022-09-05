//
//  Random.swift
//  tribie
//
//  Created by renaka agusta on 03/09/22.
//

import Foundation

struct Random {
    static func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
