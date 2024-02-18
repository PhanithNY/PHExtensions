//
//  UIKit.UICollectionView.swift
//  TwitterProfileMock
//
//  Created by Phanith Ny on 8/31/18.
//  Copyright © 2018 Phanith Ny. All rights reserved.
//

import UIKit

// MARK: - UICollectionView

public extension UICollectionView {
  
  var numberOfItems: Int {
    return (0..<numberOfSections).reduce(0) {
      $0 + self.numberOfItems(inSection: $1)
    }
  }
  
  final func register<T: UICollectionViewCell> (_: T.Type) {
    register(T.self, forCellWithReuseIdentifier: T.identifier)
  }
  
  final func dequeueReusableCell<T: UICollectionViewCell>(at indexPath: IndexPath) -> T {
    unsafeDowncast(dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath), to: T.self)
  }
  
  final func registerSupplementaryView<T: UICollectionReusableView>(_: T.Type, for kind: String) {
    register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reusableIdentifier)
  }
  
  final func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String, forIndexPath indexPath: IndexPath) -> T {
    unsafeDowncast(dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reusableIdentifier, for: indexPath), to: T.self)
  }
}

// MARK: - UICollectionViewCell

public extension UICollectionViewCell {
  
  static var identifier: String {
    return String(describing: self)
  }

}

// MARK: - UICollectionReusableView

public extension UICollectionReusableView {
  
  static var reusableIdentifier: String {
    return String(describing: self)
  }
  
}
