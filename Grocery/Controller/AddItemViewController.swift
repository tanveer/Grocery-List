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

    private func sectionHeaderViewWithText(_ text: String, section: Int) -> UIView {
        let dividerView = UIView()
        let button = UIButton(type: .system)
        let view = UIView()
        let label = UILabel()

        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitle("\u{2261}", for: .normal)
        button.tag = section
//        button.setImage(UIImage(named: "up-arrow"), for: .normal)
        button.addTarget(self, action: #selector(expandCloseSection), for: .touchUpInside)

        // section title label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = text.uppercased()

        // view
        view.addSubview(dividerView)
        view.addSubview(label)
        view.addSubview(button)

        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        button.bottomAnchor.constraint(equalTo: dividerView.topAnchor, constant: 0).isActive = true

        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        label.bottomAnchor.constraint(equalTo: dividerView.topAnchor, constant: 0).isActive = true

        dividerView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        dividerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        view.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.231372549, blue: 0.231372549, alpha: 1)
        return view
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
        return sectionHeaderViewWithText(grocery.groceryList[section].type.uppercased(), section: section)
    }
}
