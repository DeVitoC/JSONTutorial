//
//  CollectionViewCell.swift
//  JSONExample
//
//  Created by Christopher Devito on 8/4/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    var model: Model? {
        didSet {
            updateViews()
        }
    }

    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var firstItemLabel: UILabel!
    @IBOutlet weak var firstAmountLabel: UILabel!
    @IBOutlet weak var secondItemLabel: UILabel!
    @IBOutlet weak var secondAmountLabel: UILabel!
    @IBOutlet weak var craftingTableLabel: UILabel!

    func updateViews() {
        guard let model = model else { return }
        nameLabel.text = model.name
        firstItemLabel.text = "\(model.firstItem): "
        firstAmountLabel.text = "\(model.firstAmount)"
        secondItemLabel.text = "\(model.secondItem): "
        secondAmountLabel.text = "\(model.secondAmount)"
        let ctn = model.craftingTableNeeded ? "Yes" : "No"
        craftingTableLabel.text = ctn
    }

}
