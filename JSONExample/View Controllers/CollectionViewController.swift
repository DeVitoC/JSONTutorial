//
//  CollectionViewController.swift
//  JSONExample
//
//  Created by Christopher Devito on 8/4/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    // MARK: - Properties
    var modelController: ModelController?

    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        modelController?.fetchFromJSONFile()
        collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelController?.models.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.model = modelController?.models[indexPath.item]

        return cell
    }
}
