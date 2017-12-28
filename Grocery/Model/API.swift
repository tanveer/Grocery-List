//
//  Grocery.swift
//  Grocery
//
//  Created by Tanveer Bashir on 12/22/17.
//  Copyright © 2017 Tanveer Bashir. All rights reserved.
//

import UIKit

class  API {
    class func readJson(onSuccess: @escaping (GroceryItem) -> Void ) {
        let file = Bundle.main.path(forResource: "groceryData", ofType: "json")
        do {
            let fileUrl = URL(fileURLWithPath: file!)
            let data = try Data(contentsOf: fileUrl)
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            onSuccess(GroceryItem(JSON: json!)!)
        } catch {
            print(error.localizedDescription)
        }
    }
}
