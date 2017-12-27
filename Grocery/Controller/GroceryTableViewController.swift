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
    private var viewModel: ViewModel!
    private var notificationToken: NotificationToken? = nil

    @IBOutlet private weak var tableView: UITableView! {
        didSet{
            tableView.estimatedRowHeight = 50
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.register(GroceryCell.nib, forCellReuseIdentifier: GroceryCell.id)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Grocery List"
        results = realm.objects(Item.self)
        viewModel =  ViewModel()
        notificationToken = results.observe { change in
            switch change {
            case .initial(let properties):
                print("List is full")
            case .update(_, let deleted, let inserted, let modified):
                self.tableView.reloadData()
            case .error(let error):
                print(error.localizedDescription)
            }
        }

        tableView.delegate = viewModel
        tableView.dataSource = viewModel
    }
}
