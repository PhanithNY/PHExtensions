//
//  UIKit.UIBarButtonItemExtensions.swift
//  Xplore
//
//  Created by Phanith Ny on 11/19/18.
//  Copyright © 2018 Phanith Ny. All rights reserved.
//

import UIKit.UIBarButtonItem

public extension UIBarButtonItem {

  var frame: CGRect? {
    guard let view = self.value(forKey: "view") as? UIView else {
      return nil
    }
    return view.convert(view.bounds, to: nil)
  }

  var view: UIView? {
    return self.value(forKey: "view") as? UIView
  }

}
