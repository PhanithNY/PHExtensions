//
//  GenericTableViewDatasource.swift
//  SlideInVC
//
//  Created by Phanith Ny on 10/16/18.
//  Copyright © 2018 Phanith Ny. All rights reserved.
//

import UIKit

public final class GenericTableViewDatasource<Model, T>: NSObject, UITableViewDataSource where T : UITableViewCell {

  public typealias Configurator = (Model, T, Int) -> Swift.Void
  public typealias EditingHandler = (UITableViewCell.EditingStyle, IndexPath) -> Swift.Void

  public var models: [Model] = []
  public var allowEditing: Bool = false
  public var editingHandler: EditingHandler?
  
  private let cellConfigurator: Configurator

  public init(models: [Model], cellConfigurator: @escaping Configurator) {
    self.models = models
    self.cellConfigurator = cellConfigurator
  }

  public func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return models.count
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = models[indexPath.row]
    let cell: T = unsafeDowncast(tableView.dequeueReusableCell(withIdentifier: T.cellIdentifier, for: indexPath), to: T.self)
    cellConfigurator(model, cell, indexPath.row)
    return cell
  }

  public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return allowEditing
  }
  
  public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    editingHandler?(editingStyle, indexPath)
  }
  
}
