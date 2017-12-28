//
//  GroceryItem.swift
//  Grocery
//
//  Created by Tanveer Bashir on 12/23/17.
//  Copyright © 2017 Tanveer Bashir. All rights reserved.
//

import Foundation
import ObjectMapper

class GroceryItem: Mappable {

    var isExpanded: Bool = false
    var groceryList: [GroceryList]!

    required init?(map: Map) {}

    func mapping(map: Map) {
        groceryList  <- map["results"]
    }
}
