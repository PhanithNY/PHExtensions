//
//  UIKit.UIScrollView.swift
//  Xplore
//
//  Created by Phanith Ny on 12/20/18.
//  Copyright © 2018 Phanith Ny. All rights reserved.
//

import UIKit

public extension UIScrollView {

  final func scrollToTop(animated: Bool = true) {
    scrollRectToVisible(CGRect(x: 0, y: 0, size: CGSize(width: 1, height: 1)), animated: animated)
  }

  final func scrollRectToBottom(animated: Bool = true) {
    if self.contentInset.bottom <= 0 { return }
    
    let offset: CGPoint = .init(x: 0, y: self.contentSize.height - self.bounds.size.height + self.contentInset.bottom)
    setContentOffset(offset, animated: animated)
  }
  
}
