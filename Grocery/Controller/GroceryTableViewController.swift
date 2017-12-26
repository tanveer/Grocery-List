//
//  ViewController.swift
//  Grocery
//
//  Created by Tanveer Bashir on 12/21/17.
//  Copyright © 2017 Tanveer Bashir. All rights reserved.
//

import UIKit
import RealmSwift

class GroceryTableViewController: UIViewController {

    private var items: Results<Item>!

    @IBOutlet private weak var tableView: UITableView! {
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(GroceryCell.nib, forCellReuseIdentifier: GroceryCell.id)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Grocery List"
        items = RealmData.realm.objects(Item.self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }
}

extension GroceryTableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroceryCell.id, for: indexPath) as! GroceryCell
        cell.item = items[indexPath.row].name
        return cell
    }
}

extension GroceryTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        if editingStyle == .delete {
            RealmData.delete(item)
            tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! GroceryCell
        cell.accessoryType = .checkmark
        cell.itemLabel.attributedText = items[indexPath.row].name.attributedString()
    }
}
