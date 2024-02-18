//
//  UIKit.CGRect.swift
//  TwitterProfileMock
//
//  Created by Phanith Ny on 8/31/18.
//  Copyright © 2018 Phanith Ny. All rights reserved.
//

import CoreGraphics

public extension CGRect {
  
  var center: CGPoint {
    return CGPoint(x: midX, y: midY)
  }
  
  init(_ values: (CGFloat, CGFloat, CGFloat, CGFloat)) {
    self.init(x: values.0, y: values.1, width: values.2, height: values.3)
  }
  
  init(origin: CGPoint, width: CGFloat, height: CGFloat) {
    self.init(x: origin.x, y: origin.y, width: width, height: height)
  }
  
  init(x: CGFloat, y: CGFloat, size: CGSize) {
    self.init(x: x, y: y, width: size.width, height: size.height)
  }
}

