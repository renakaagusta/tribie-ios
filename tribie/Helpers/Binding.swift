//
//  Binding.swift
//  tribie
//
//  Created by renaka agusta on 30/08/22.
//

import SwiftUI

extension Binding {
    func onChange(execute: @escaping (Value) ->Void) -> Binding {
        return Binding(
            get: {
                return self.wrappedValue
            },
            set: {
                self.wrappedValue = $0
                execute($0)
            }
        )
    }
}
