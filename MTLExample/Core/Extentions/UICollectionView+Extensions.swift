//
//  UICollectionView+Extensions.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

extension UICollectionView {
    internal func register(nibName: String) {
        let nib = UINib(nibName: nibName, bundle: .main)
        register(nib, forCellWithReuseIdentifier: nibName)
    }
}
