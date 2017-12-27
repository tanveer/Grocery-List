//
//  GroceryItemCell.swift
//  Grocery
//
//  Created by Tanveer Bashir on 12/22/17.
//  Copyright © 2017 Tanveer Bashir. All rights reserved.
//

import UIKit
import RealmSwift

class GroceryItemCell: UITableViewCell {
    var item: String? {
        didSet{
            updateUi()
        }
    }
    @IBOutlet private weak var itemLabel: UILabel!
    @IBOutlet weak var addedLabel: UILabel!

    private func updateUi() {
        if let item = self.item {
            itemLabel.text = item
        }
    }
}

extension GroceryItemCell {
    static var id: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: id, bundle: nil)
    }
}
