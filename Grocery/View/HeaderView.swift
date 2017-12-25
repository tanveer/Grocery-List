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
        self.button.tag = section
        self.titleLabel.text = text.uppercased()

        // add subviews to contentView
        contentView.addSubview(dividerView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(button)

        // set constraint for subviews
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        button.bottomAnchor.constraint(equalTo: dividerView.topAnchor, constant: 0).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: dividerView.topAnchor, constant: 0).isActive = true

        dividerView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        contentView.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.231372549, blue: 0.231372549, alpha: 1)
        return contentView
    }
}

extension HeaderView {
    static var id: String {
        return String(describing: self)
    }
}
