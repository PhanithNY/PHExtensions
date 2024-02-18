//
//  UIKit.CGPoint.swift
//  TwitterProfileMock
//
//  Created by Phanith Ny on 8/31/18.
//  Copyright © 2018 Phanith Ny. All rights reserved.
//

import CoreGraphics

public extension CGPoint {
  
  var length: CGFloat {
    sqrt((x * x) + (y * y))
  }
  
  func distance(to point: CGPoint) -> CGFloat {
    sqrt(distanceSquared(to: point))
  }
  
  func distanceSquared(to point: CGPoint) -> CGFloat {
    ((x - point.x) * (x - point.x)) + ((y - point.y) * (y - point.y))
  }
}
