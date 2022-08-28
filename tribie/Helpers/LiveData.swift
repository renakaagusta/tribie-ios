//
//  LiveData.swift
//  tribie
//
//  Created by renaka agusta on 28/08/22.
//

import Foundation

final class LiveData<T> {
  typealias Listener = (T) -> Void
  var listener: Listener?
    
  var value: T {
    didSet {
      listener?(value)
    }
  }
    
  init(_ value: T) {
    self.value = value
  }
    
  func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
