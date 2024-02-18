//
//  SectionedCollectionViewDatasource.swift
//  SlideInVC
//
//  Created by Phanith Ny on 10/16/18.
//  Copyright © 2018 Phanith Ny. All rights reserved.
//

import UIKit

public final class SectionedCollectionViewDatasource: NSObject {

  private let datasources: [UICollectionViewDataSource]

  public init(datasources: [UICollectionViewDataSource]) {
    self.datasources = datasources
  }

}

// MARK: - UICollectionViewDataSource

extension SectionedCollectionViewDatasource: UICollectionViewDataSource {

  public func numberOfSections(in collectionView: UICollectionView) -> Int {
    datasources.count
  }

  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let datasource = datasources[section]
    return datasource.collectionView(collectionView, numberOfItemsInSection: 0)
  }

  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let datasource = datasources[indexPath.section]
    let indexPath = IndexPath(item: indexPath.item, section: 0)
    return datasource.collectionView(collectionView, cellForItemAt: indexPath)
  }

}
