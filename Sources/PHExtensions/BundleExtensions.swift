//
//  BundleExtensions.swift
//  Xplore
//
//  Created by Phanith Ny on 2/23/20.
//  Copyright © 2020 Phanith Ny. All rights reserved.
//

import Foundation

public extension Bundle {
  var appName: String? {
    self.object(forInfoDictionaryKey: kCFBundleNameKey as String) as? String
  }
  
  var versionNumber: String? {
    self.infoDictionary?["CFBundleShortVersionString"] as? String
  }
  
  var buildNumber: String? {
    self.infoDictionary?["CFBundleVersion"] as? String
  }
}
