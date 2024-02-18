//
//  NSTextAttachmentExtensions.swift
//  Xplore
//
//  Created by PhanithNY on 3/11/19.
//  Copyright © 2019 Phanith Ny. All rights reserved.
//

import UIKit

extension NSTextAttachment {
  
  func setImageHeight(height: CGFloat) {
    guard let image = image else { return }
    let ratio = image.size.width / image.size.height
    bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: ratio * height, height: height)
  }
  
}
