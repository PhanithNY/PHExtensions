//
//  OptionalExtensions.swift
//  Xplore
//
//  Created by Phanith Ny on 10/27/19.
//  Copyright © 2019 Phanith Ny. All rights reserved.
//

import Foundation

public extension Optional where Wrapped == String {
  
  var orEmpty: String {
    switch self {
    case .some(let value):
      return value
      
    case .none:
      return ""
    }
  }
}

public extension Optional {
  
  func value(_ handler: (Wrapped) -> Swift.Void) {
    flatMap(handler)
  }
  
}
