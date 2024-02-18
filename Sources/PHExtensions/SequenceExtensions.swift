//
//  SequenceExtensions.swift
//  Xplore
//
//  Created by Phanith Ny on 12/21/19.
//  Copyright © 2019 Phanith Ny. All rights reserved.
//

import Foundation

public extension Sequence {
  
  // array.sorted(on: { $0.property })
  func sorted<T: Comparable>(on propertyAccessor: (Iterator.Element) -> T) -> Array<Iterator.Element> {
    return sorted(by: { propertyAccessor($0) < propertyAccessor($1) })
  }
  
}
