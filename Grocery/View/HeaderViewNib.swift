//
//  HeaderViewNib.swift
//  Grocery
//
//  Created by Tanveer Bashir on 12/25/17.
//  Copyright © 2017 Tanveer Bashir. All rights reserved.
//

import UIKit

protocol ButtonToggleDelegate {
    func expandHeadeView(with tableView: UITableView, grocery: GroceryItem, section : Int)
}

class HeaderViewNib: UIView {
    @IBOutlet weak var titleLabel: UILabel!
}

extension HeaderViewNib {
    static var id: String {
        return String(describing: self)
    }
}

extension UIView {
    func blureEffects() {
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.isUserInteractionEnabled = false
        visualEffectView.frame = bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(visualEffectView, at: 0)
    }
}
