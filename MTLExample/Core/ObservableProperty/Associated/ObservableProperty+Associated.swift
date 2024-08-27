//
//  ObservableProperty+Associated.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

fileprivate var initialKey: UInt8 = 0

extension ObservableProperty {
    internal func observe(for target: NSObject) -> ObservableProperty<Value>.Observe {
        let key      = target.pointer+pointer
        let observes = target.observes()
        if let observe = observes[key] as? ObservableProperty<Value>.Observe {
            return observe
        }
        else {
            observes[key] = ObservableProperty<Value>.Observe(target: target)
        }
        return observes[key] as! ObservableProperty<Value>.Observe
    }
}

extension NSObject {
    fileprivate func observes() -> NSMutableDictionary {
        return withUnsafePointer(to: &initialKey) { [weak self] in
            guard let self else {
                return NSMutableDictionary()
            }
            if let objc = objc_getAssociatedObject(self, $0) {
                return objc as! NSMutableDictionary
            }
            else {
                objc_setAssociatedObject(self, $0, NSMutableDictionary(), .OBJC_ASSOCIATION_RETAIN)
            }
            return objc_getAssociatedObject(self, $0) as! NSMutableDictionary
        }
    }
}

