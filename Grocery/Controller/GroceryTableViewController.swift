//
//  ViewController.swift
//  Grocery
//
//  Created by Tanveer Bashir on 12/21/17.
//  Copyright © 2017 Tanveer Bashir. All rights reserved.
//

import UIKit
import RealmSwift
import DZNEmptyDataSet

class GroceryTableViewController: UIViewController, TableViewHeaderFooterViewDelegate {

    func setClearState(for comeplted: Results<Completed>) {
        UIView.animate(withDuration: 0.3) {
            self.tableView.tableFooterView?.isHidden = comeplted.isEmpty ? true : false

        }
    }

    private var viewModel: ViewModel!
    private var notificationToken: NotificationToken? = nil
    @IBOutlet weak var clearButton: UIButton!

    @IBOutlet private weak var tableView: UITableView! {
        didSet{
            tableView.estimatedRowHeight = 50
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.register(GroceryCell.nib, forCellReuseIdentifier: GroceryCell.id)
            tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderView.id)
            tableView.emptyDataSetSource = self
            tableView.emptyDataSetDelegate = self
        }
    }

    @IBAction func clear(_ sender: UIButton) {
        if let completed = viewModel.completed {
            for item in completed {
                RealmData.delete(item)
                let index = viewModel.completed.count
                let indexPath = IndexPath(item: index, section: 0)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Grocery List".uppercased()

        results = realm.objects(Item.self)
        viewModel =  ViewModel()
        notificationToken = results.observe { change in
            switch change {
            case .initial(let properties):
                print("List is full\(properties)")
            case .update(_, _, _, _):
                self.tableView.reloadData()
            case .error(let error):
                print(error.localizedDescription)
            }
        }

        viewModel.delegate = self
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
    }
}

extension GroceryTableViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let para = NSMutableParagraphStyle()
        para.lineBreakMode = NSLineBreakMode.byWordWrapping
        para.alignment = NSTextAlignment.center

        let attribs = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14),
            NSAttributedStringKey.foregroundColor: UIColor.lightGray,
            NSAttributedStringKey.paragraphStyle: para
        ]

        return NSAttributedString(string: "Grocery list", attributes: attribs)
    }

    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let para = NSMutableParagraphStyle()
        para.lineBreakMode = NSLineBreakMode.byWordWrapping
        para.alignment = NSTextAlignment.center

        let attribs = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14),
            NSAttributedStringKey.foregroundColor: UIColor.lightGray,
            NSAttributedStringKey.paragraphStyle: para
        ]

        return NSAttributedString(string: "Click on ' + ' to start", attributes: attribs)
    }
}
