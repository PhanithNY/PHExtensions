//
//  UIKit.UIEdgeInset.swift
//  TwitterProfileMock
//
//  Created by Phanith Ny on 8/31/18.
//  Copyright © 2018 Phanith Ny. All rights reserved.
//

import UIKit

public extension UIEdgeInsets {

  var topLeft: CGPoint {
    CGPoint(x: left, y: top)
  }
  
  var bottomRight: CGPoint {
    CGPoint(x: right, y: bottom)
  }
}
