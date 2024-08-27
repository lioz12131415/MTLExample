//
//  Animations+Associated.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

fileprivate var initialKey: UInt8 = 0

extension UIView {
    internal var animations: Animations {
        return withUnsafePointer(to: &initialKey) { [weak self] in
            guard let self else {
                return Animations()
            }
            if let objc = objc_getAssociatedObject(self, $0) {
                return objc as! Animations
            }
            else {
                objc_setAssociatedObject(self, $0, Animations(self), .OBJC_ASSOCIATION_RETAIN)
            }
            return objc_getAssociatedObject(self, $0) as! Animations
        }
    }
}
