//
//  GroceryList.swift
//  Grocery
//
//  Created by Tanveer Bashir on 12/23/17.
//  Copyright © 2017 Tanveer Bashir. All rights reserved.
//

import Foundation
import ObjectMapper

class GroceryList: GroceryItem {

    var id: Int!
    var items: [String]!
    var type: String!

    required init?(map: Map) {
        super.init(map: map)
    }

    override func mapping(map: Map) {
        super.mapping(map: map)

        id          <- map["id"]
        items       <- map["items"]
        type        <- map["type"]
    }
}
