//
//  GenericCollectionViewDatasource.swift
//  SlideInVC
//
//  Created by Phanith Ny on 10/16/18.
//  Copyright © 2018 Phanith Ny. All rights reserved.
//

import UIKit

public final class GenericCollectionViewDatasource<Model, T> : NSObject, UICollectionViewDataSource where T : UICollectionViewCell {

  public typealias Configurator = (Model, T, Int) -> Swift.Void

  public var models: [Model] = []
  private let cellConfigurator: Configurator

  public init(models: [Model],
       cellConfigurator: @escaping Configurator) {
    self.models = models
    self.cellConfigurator = cellConfigurator
  }

  public func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return models.count
  }

  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let model = models[indexPath.row]
    let cell: T = unsafeDowncast(collectionView.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath), to: T.self)
    cellConfigurator(model, cell, indexPath.row)
    return cell
  }

}
