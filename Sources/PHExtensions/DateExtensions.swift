//
//  DateExtensions.swift
//  Xplore
//
//  Created by Phanith Ny on 2/29/20.
//  Copyright © 2020 Phanith Ny. All rights reserved.
//

import Foundation

public extension Date {
  
  func years(since date: Date) -> Int? {
    return Calendar.current.dateComponents([.year], from: date, to: self).year
  }
  
  func months(since date: Date) -> Int? {
    return Calendar.current.dateComponents([.month], from: date, to: self).month
  }
  
  func days(since date: Date) -> Int? {
    return Calendar.current.dateComponents([.day], from: date, to: self).day
  }
  
  func hours(since date: Date) -> Int? {
    return Calendar.current.dateComponents([.hour], from: date, to: self).hour
  }
  
  func minutes(since date: Date) -> Int? {
    return Calendar.current.dateComponents([.minute], from: date, to: self).minute
  }
  
  func seconds(since date: Date) -> Int? {
    return Calendar.current.dateComponents([.second], from: date, to: self).second
  }
  
}
