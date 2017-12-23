//
//  Grocery.swift
//  Grocery
//
//  Created by Tanveer Bashir on 12/22/17.
//  Copyright © 2017 Tanveer Bashir. All rights reserved.
//

import UIKit


struct Grocery {

    static func data(for key: String) -> [String] {
        guard let file = Bundle.main.path(forResource: "groceryData", ofType: "json") else { return ["nil"] }
        do {
            let fileUrl = URL(fileURLWithPath: file)
            let data = try Data(contentsOf: fileUrl)
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: [String]]]
            for items in json! {
                if let items = items[key] {
                    return items
                }
            }
        } catch {
            print(error.localizedDescription)
        }

        return ["Items not available"]
    }

    static func dataDict(for key: String) -> [String] {
        guard let file = Bundle.main.path(forResource: "groceryData", ofType: "json") else { return [] }
        do {
            let fileUrl = URL(fileURLWithPath: file)
            let data = try Data(contentsOf: fileUrl)
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: [String]]]
            for items in json! {
                if let items = items[key] {
                    return items
                }
            }
        } catch {
            print(error.localizedDescription)
        }

        return []
    }
}
