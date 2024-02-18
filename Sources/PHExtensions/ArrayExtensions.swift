//
//  ArrayExtensions.swift
//  Xplore
//
//  Created by Phanith Ny on 7/12/19.
//  Copyright © 2019 Phanith Ny. All rights reserved.
//

import Foundation

public extension Array {
  
  func chunked(into size: Int) -> [[Element]] {
    return stride(from: 0, to: count, by: size).map {
      Array(self[$0 ..< Swift.min($0 + size, count)])
    }
  }
  
  func element(at index: Int) -> Element? {
    guard index >= 0, index < endIndex else {
      return nil
    }
    return self[index]
  }
  
  mutating func mutateMap(_ element: (inout Element) -> ()) {
    for index in indices {
      element(&self[index])
    }
  }
  
}

public extension RangeReplaceableCollection where Element: Hashable {
  var orderedSet: Self {
    var set = Set<Element>()
    return filter { set.insert($0).inserted }
  }
  
  mutating func removeDuplicates() {
    var set = Set<Element>()
    removeAll { !set.insert($0).inserted }
  }
}
