//
//  UITableView+Extensions.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

extension UITableView {
    internal func register(nibName: String) {
        let nib = UINib(nibName: nibName, bundle: Bundle.main)
        register(nib, forCellReuseIdentifier: nibName)
    }
}
