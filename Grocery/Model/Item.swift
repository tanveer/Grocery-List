//
//  Item.swift
//  Grocery
//
//  Created by Tanveer Bashir on 12/21/17.
//  Copyright © 2017 Tanveer Bashir. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Item: Object {

    dynamic var name: String = ""

    override static func primaryKey() -> String? {
        return "name"
    }

    convenience init(name: String) {
        self.init()
        self.name = name
    }
}

