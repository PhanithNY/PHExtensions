//
//  UIKit.FloatingPoint.swift
//  TwitterProfileMock
//
//  Created by Phanith Ny on 8/31/18.
//  Copyright © 2018 Phanith Ny. All rights reserved.
//

import Foundation

public extension FloatingPoint {
  
  func toRadians() -> Self {
    (self/180) * type(of: self).pi
  }
  
  func toDegrees() -> Self {
    (self/type(of: self).pi) * 180
  }
  
  func ratio(min: Self, max: Self) -> Self {
    (self - min)/(max - min)
  }
}
