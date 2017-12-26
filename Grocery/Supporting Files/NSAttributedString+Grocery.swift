//
//  NSAttributedString+Grocery.swift
//  Grocery
//
//  Created by Tanveer Bashir on 12/25/17.
//  Copyright © 2017 Tanveer Bashir. All rights reserved.
//

import UIKit

extension String {
    func attributedString() -> NSAttributedString {
        let attributesString = NSAttributedString(string: self, attributes: Grocery.attributes())
        return attributesString
    }
}

func attributes() -> [NSAttributedStringKey: Any] {
    var attributes: [NSAttributedStringKey: Any] = [:]
    attributes[.font] = UIFont.boldSystemFont(ofSize: 20)
    attributes[.strikethroughStyle]  = 3
    attributes[.strokeColor] = UIColor.black
    attributes[.foregroundColor] = UIColor.blue
    return attributes
}
