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
    private var objects: Results<Item>!
    var item: String? {
        didSet{
            updateUi()
        }
    }
    
    @IBOutlet private weak var itemLabel: UILabel!
    @IBOutlet weak var addedLabel: UILabel!

    private func updateUi() {
        objects = RealmData.realm.objects(Item.self)
        for object in objects {
            if object.name == item {
                self.accessoryType = object.name == item ? .checkmark : .none
                self.item = object.name
                self.addedLabel.text = ""
            }
        }

        if let item = self.item {
            itemLabel.text = item
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
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
