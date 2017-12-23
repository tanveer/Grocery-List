//
//  AddItemViewController.swift
//  Grocery
//
//  Created by Tanveer Bashir on 12/21/17.
//  Copyright © 2017 Tanveer Bashir. All rights reserved.
//

import UIKit
import RealmSwift

class AddItemViewController: UIViewController {
    private var items: [String] = []
    private var objects: Results<Item>!
    private let sections = ["Meat", "Vegies", "Fruits", "Cheese", "Dairy", "Seafood", "Baking"]

    @IBOutlet private weak var tableView: UITableView!{
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(GroceryItemCell.nib, forCellReuseIdentifier: GroceryItemCell.id)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        objects = RealmData.realm.objects(Item.self)
    }
}

extension AddItemViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Grocery.data(for: sections[section]).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroceryItemCell.id, for: indexPath) as! GroceryItemCell
        let item = Grocery.data(for: sections[indexPath.section])[indexPath.row]
        for object in objects {
            if object.name == item {
                cell.accessoryType = object.name == item ? .checkmark : .none
                cell.item = item
                return cell
            }
        }
        cell.item = item
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
}

extension AddItemViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = Grocery.data(for: sections[indexPath.section])[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! GroceryItemCell
        if RealmData.realm.object(ofType: Item.self, forPrimaryKey: item) == nil {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            RealmData.create(Item(name: item))
        } else if cell.accessoryType == .checkmark {
            let object = objects.filter { $0.name == item }
            RealmData.delete(object.last!)
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
