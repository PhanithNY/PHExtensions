//
//  UIKit.UISearchBar.swift
//  Xplore
//
//  Created by Phanith Ny on 12/17/18.
//  Copyright © 2018 Phanith Ny. All rights reserved.
//

import UIKit

public extension UISearchBar {
  
  var textField: UITextField? {
    searchTextField
  }
  
  final func setBackgroundColor(_ color: UIColor) {
    searchTextField.backgroundColor = color
  }
}
