//
//  ViewModelItem.swift
//  Grocery
//
//  Created by Tanveer Bashir on 12/26/17.
//  Copyright © 2017 Tanveer Bashir. All rights reserved.
//

import Foundation
import RealmSwift

class ViewModelItem {
    var isSelected = false
    var item: Item!

    init(item: Item) {
        self.item = item
    }
}

class ViewModel: NSObject {
    var items = results.map {ViewModelItem(item: $0)}

    private func emptyView(for tableView: UITableView) {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "List is empty add some items to begin shopping!"
        tableView.backgroundColor = .black
        if let view = tableView.backgroundView {
           view.addSubview(label)
        }
    }
}

extension ViewModel: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  items.isEmpty ? 0 : items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !items.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: GroceryCell.id, for: indexPath) as! GroceryCell
            cell.vmi = items[indexPath.row]
            if items[indexPath.row].isSelected {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            } else {
                tableView.deselectRow(at: indexPath, animated: false)
            }
            return cell
        } else {
            return  UITableViewCell()
        }
    }
}

extension ViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        item.isSelected = true
        if item.isSelected {
            RealmData.delete(item.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        items[indexPath.row].isSelected = false
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        if editingStyle == .delete {
            RealmData.delete(item.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
