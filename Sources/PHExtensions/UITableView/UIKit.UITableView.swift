//
//  UIKit.UITableView.swift
//  TwitterProfileMock
//
//  Created by Phanith Ny on 8/31/18.
//  Copyright © 2018 Phanith Ny. All rights reserved.
//

import UIKit

public extension UITableView {
  
  var numberOfRows: Int {
    return (0..<numberOfSections).reduce(0) {
      $0 + self.numberOfRows(inSection: $1)
    }
  }
  
  var allIndexPaths: [IndexPath] {
    return (0..<numberOfSections).flatMap { section in
      (0..<numberOfRows(inSection: section)).map { row in
        IndexPath(row: row, section: section)
      }
    }
  }
  
  final func insertSection(_ section: Int, with animation: UITableView.RowAnimation) {
    insertSections(IndexSet(integer: section), with: animation)
  }
  
  final func deleteSection(_ section: Int, with animation: UITableView.RowAnimation) {
    deleteSections(IndexSet(integer: section), with: animation)
  }
  
  final func reloadSection(_ section: Int, with animation: UITableView.RowAnimation) {
    reloadSections(IndexSet(integer: section), with: animation)
  }
  
  final func dequeueReusableCell<T: UITableViewCell>(at indexPath: IndexPath) -> T {
    unsafeDowncast(dequeueReusableCell(withIdentifier: T.cellIdentifier, for: indexPath), to: T.self)
  }
  
  final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
    unsafeDowncast(dequeueReusableHeaderFooterView(withIdentifier: T.defaultIdentifier).unsafelyUnwrapped, to: T.self)
  }

  final func register<T: UITableViewCell>(_: T.Type)  {
    register(T.self, forCellReuseIdentifier: T.cellIdentifier)
  }
  
  final func registerHeaderFooter<T: UITableViewHeaderFooterView>(_: T.Type) {
    register(T.self, forHeaderFooterViewReuseIdentifier: T.defaultIdentifier)
  }
}

// MARK: - UITableViewCell

public extension UITableViewCell {
  static var cellIdentifier: String {
    return String(describing: self)
  }
}

// MARK: - UITableViewHeaderFooterView

public extension UITableViewHeaderFooterView {
  static var defaultIdentifier: String {
    return String(describing: self)
  }
}
