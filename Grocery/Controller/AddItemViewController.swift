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
    private var grocery: GroceryItem!
    private var objects: Results<Item>!

    @IBOutlet private weak var tableView: UITableView!{
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(GroceryItemCell.nib, forCellReuseIdentifier: GroceryItemCell.id)
            tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderView.id)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        Grocery.readJson { groceyItem in
            self.grocery = groceyItem
            self.tableView.reloadData()
        }
        objects = RealmData.realm.objects(Item.self)
    }

    @objc dynamic private func expandCloseSection(button: UIButton) {
        let section = button.tag
        let indexPaths = grocery.groceryList[section].items.indices.map {  IndexPath(row: $0, section: section) }
        grocery.groceryList[section].isExpanded = !grocery.groceryList[section].isExpanded
        button.setTitle(grocery.groceryList[section].isExpanded ? "×" : "\u{2261}", for: .normal)
        if grocery.groceryList[section].isExpanded {
            tableView.insertRows(at: indexPaths, with: .fade)
        } else {
            tableView.deleteRows(at: indexPaths, with: .fade)
        }
    }
}

extension AddItemViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return grocery.groceryList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if grocery.groceryList[section].isExpanded {
            return  grocery.groceryList[section].items.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroceryItemCell.id, for: indexPath) as! GroceryItemCell
        let section = indexPath.section
        let item = grocery.groceryList[section].items[indexPath.row]
        for object in objects {
            if object.name == item {
                cell.accessoryType = object.name == item ? .checkmark : .none
                cell.item = item
                cell.addedLabel.text = "Added"
                return cell
            }
        }
        cell.item = item
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        cell.addedLabel.text = ""
        return cell
    }
}

extension AddItemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = grocery.groceryList[indexPath.section].items[indexPath.row]
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

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.id) as? HeaderView {
            headerView.button.addTarget(self, action: #selector(expandCloseSection), for: .touchUpInside)
            return headerView.sectionHeaderViewWithText(grocery.groceryList[section].type, section: section)
        }
        else {
            return UIView()
        }
    }
}
