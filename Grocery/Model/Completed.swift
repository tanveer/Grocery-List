//
//  Completed.swift
//  Grocery
//
//  Created by Tanveer Bashir on 12/27/17.
//  Copyright © 2017 Tanveer Bashir. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Completed: Object {
    dynamic var item: String = ""

    convenience init(item: String) {
        self.init()
        self.item = item
    }
}
