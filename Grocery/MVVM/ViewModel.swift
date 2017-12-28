//
//  ViewModel.swift
//  Grocery
//
//  Created by Tanveer Bashir on 1/16/18.
//  Copyright © 2018 Tanveer Bashir. All rights reserved.
//

import UIKit
import RealmSwift

protocol TableViewHeaderFooterViewDelegate {
    func setClearState(for comeplted: Results<Completed>)
}

class ViewModel: NSObject {
    var items = results.map {ViewGroceryItem(item: $0)}
    var completed: Results<Completed>!
    var delegate: TableViewHeaderFooterViewDelegate?

    override init() {
        self.completed = realm.objects(Completed.self)
    }

    private func setCheckmark(for cell: GroceryCell , for item: Item) {
        if let isSelected = item.isSelected {
            if isSelected  {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
    }
}

extension ViewModel: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        if completed.isEmpty {
            tableView.tableFooterView?.isHidden = true
        }
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return completed.count
        } else {
            return items.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "completed", for: indexPath)
            cell.textLabel?.text = completed[indexPath.row].item
            cell.accessoryType = .checkmark
            return cell
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: GroceryCell.id, for: indexPath) as? GroceryCell {
                cell.viewGroceryItem = items[indexPath.row]
                setCheckmark(for: cell, for: items[indexPath.row].item)
                return cell
            }
            return UITableViewCell()
        }
    }
}

extension ViewModel: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = items[indexPath.row].item {
            RealmData.create(Completed(item: item.name))
            delegate?.setClearState(for: completed)
            RealmData.delete(item)
            tableView.reloadData()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let complete = completed[indexPath.row]
            if editingStyle == .delete {
                RealmData.delete(complete)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case 1:
            let item = items[indexPath.row]
            if editingStyle == .delete {
                RealmData.delete(item.item)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            if !completed.isEmpty {
                return 60
            }
        case 1:
            if !items.isEmpty {
                return 60
            }
        default:
            break
        }
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section  {
        case 0:
            if !completed.isEmpty {
                if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.id) as? HeaderView {
                    return headerView.sectionHeaderViewWithText("Completed", section: section)
                }
            }
        case 1:
            if !items.isEmpty {
                if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.id) as? HeaderView {
                    return headerView.sectionHeaderViewWithText("Open Items", section: section)
                }
            }
        default:
            break
        }
        return nil
    }
}
