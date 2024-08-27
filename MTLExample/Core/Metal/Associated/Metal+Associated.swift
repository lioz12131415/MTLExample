//
//  Metal+Associated.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

fileprivate var initialKey: UInt8 = 0

extension UIImageView {
    internal var metal: Metal {
        return withUnsafePointer(to: &initialKey) { [weak self] in
            guard let self else {
                return Metal()
            }
            if let objc = objc_getAssociatedObject(self, $0) {
                return objc as! Metal
            }
            else {
                objc_setAssociatedObject(self, $0, Metal(target: self), .OBJC_ASSOCIATION_RETAIN)
            }
            return objc_getAssociatedObject(self, $0) as! Metal
        }
    }
}
