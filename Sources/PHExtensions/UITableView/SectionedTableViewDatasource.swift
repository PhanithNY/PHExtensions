//
//  SectionedTableViewDatasource.swift
//  SlideInVC
//
//  Created by Phanith Ny on 10/16/18.
//  Copyright © 2018 Phanith Ny. All rights reserved.
//

import UIKit

public final class SectionedTableViewDatasource: NSObject {

  private let datasources: [UITableViewDataSource]

  public init(datasources: [UITableViewDataSource]) {
    self.datasources = datasources
  }

}

extension SectionedTableViewDatasource: UITableViewDataSource {

  public func numberOfSections(in tableView: UITableView) -> Int {
    return datasources.count
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let datasource = datasources[section]
    return datasource.tableView(tableView, numberOfRowsInSection: 0)
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let datasource = datasources[indexPath.section]
    let indexPath = IndexPath(row: indexPath.row, section: 0)
    return datasource.tableView(tableView, cellForRowAt: indexPath)
  }

}
