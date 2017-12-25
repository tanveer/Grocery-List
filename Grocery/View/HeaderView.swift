//
//  HeaderView.swift
//  Grocery
//
//  Created by Tanveer Bashir on 12/25/17.
//  Copyright © 2017 Tanveer Bashir. All rights reserved.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

    override var reuseIdentifier: String? {
        return HeaderView.id
    }

     var button: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitle("\u{2261}", for: .normal)
        return button
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    private var dividerView: UIView = {
        let dividerView = UIView()
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return dividerView
    }()

    func sectionHeaderViewWithText(_ text: String, section: Int) -> UIView {
            button.tag = section
        if  let nibView = Bundle.main.loadNibNamed(HeaderViewNib.id, owner: self, options: nil)?.first as? HeaderViewNib {
            nibView.titleLabel.text = text.uppercased()
            nibView.addSubview(button)
            contentView.addSubview(nibView)

            button.widthAnchor.constraint(equalToConstant: 60).isActive = true
            button.trailingAnchor.constraint(equalTo: nibView.trailingAnchor, constant: 0).isActive = true
            button.topAnchor.constraint(equalTo: nibView.topAnchor, constant: 8).isActive = true
            button.bottomAnchor.constraint(equalTo: nibView.bottomAnchor, constant: 0).isActive = true

            nibView.translatesAutoresizingMaskIntoConstraints = false
            nibView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
            nibView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
            nibView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
            nibView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        }
        return contentView
    }
}

extension HeaderView {
    static var id: String {
        return String(describing: self)
    }
}
