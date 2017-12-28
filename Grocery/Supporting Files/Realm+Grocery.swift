//
//  Realm+Grocery.swift
//  Grocery
//
//  Created by Tanveer Bashir on 12/21/17.
//  Copyright © 2017 Tanveer Bashir. All rights reserved.
//

import Foundation
import RealmSwift

class RealmData {

    static var realm: Realm {
        let realm = try! Realm()
        return realm
    }

    class func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch  {
            assertionFailure(error.localizedDescription)
        }
    }

    class func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch  {
            assertionFailure(error.localizedDescription)
        }
    }

    class func update<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object, update: true)
            }
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
}
