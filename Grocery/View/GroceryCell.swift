//
//  GroceryCell.swift
//  Grocery
//
//  Created by Tanveer Bashir on 12/21/17.
//  Copyright © 2017 Tanveer Bashir. All rights reserved.
//

import UIKit

class GroceryCell: UITableViewCell {
    var item: String? {
        didSet{
            if let item = item {
                itemLabel.text = item 
            }
        }
    }
    
    @IBOutlet weak var itemLabel: UILabel!
}

extension GroceryCell {
    static var id: String {
        return String(describing: self)
    }

    static var nib: UINib {
        return UINib(nibName: GroceryCell.id, bundle: nil)
    }
}
