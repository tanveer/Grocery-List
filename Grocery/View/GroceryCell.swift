//
//  GroceryCell.swift
//  Grocery
//
//  Created by Tanveer Bashir on 12/21/17.
//  Copyright © 2017 Tanveer Bashir. All rights reserved.
//

import UIKit

class GroceryCell: UITableViewCell {
    var vmi: ViewModelItem? {
        didSet{
            if let vmi = vmi {
                itemLabel.text = vmi.item.name
            }
        }
    }
    
    @IBOutlet weak var itemLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        accessoryType = selected ? .checkmark : .none
    }
}

extension GroceryCell {
    static var id: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: GroceryCell.id, bundle: nil)
    }
}
