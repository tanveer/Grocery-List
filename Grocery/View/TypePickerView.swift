//
//  TypePickerView.swift
//  Grocery
//
//  Created by Tanveer Bashir on 12/21/17.
//  Copyright © 2017 Tanveer Bashir. All rights reserved.
//

import UIKit

class TypePickerView: UIPickerView {

    var type: String? {
        didSet{
            items = Grocery.data(for: type!)
        }
    }

    private var items: [String] = []
    private let componentHight: CGFloat = 21
    private let componentWidth: CGFloat = 250
}

extension TypePickerView: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

extension TypePickerView: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(items[row])
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return componentHight * 3
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width, height: componentHight))
        let typeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width, height: componentHight))

        typeLabel.text = items[row]
        typeLabel.textAlignment = .center
        typeLabel.textColor = .white
        view.addSubview(typeLabel)
        return view
    }
}
