//
//  ObservableProperty.Observe.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

extension ObservableProperty {
    final class Observe: NSObject, ReciveablePropertyObserve {
        
        fileprivate weak var target: NSObject? = nil
                
        fileprivate var didSetBlock:  ((Value, Value) -> Void)?
        fileprivate var willSetBlock: ((Value, Value) -> Void)?
        
        internal init(target: NSObject?) {
            self.target = target
        }
        
        internal func remove() {
            self.didSetBlock  = nil
            self.willSetBlock = nil
        }
        
        internal func didSet(_ newValue: Value, _ oldValue: Value) {
            guard target != nil else { return }
            self.didSetBlock?(newValue, newValue)
        }
        
        internal func willSet(_ newValue: Value, _ oldValue: Value) {
            guard target != nil else { return }
            self.willSetBlock?(newValue, oldValue)
        }
        
        internal func didSet(_ block: @escaping(_ newValue: Value, _ oldValue: Value) -> Void) {
            self.didSetBlock = (block)
        }
        
        internal func willSet(_ block: @escaping(_ newValue: Value, _ oldValue: Value) -> Void) {
            self.willSetBlock = (block)
        }
    }
}

protocol ReciveablePropertyObserve<Value> {
    associatedtype Value: Equatable
    func didSet(_ block: @escaping(_ newValue: Value, _ oldValue: Value) -> Void)
    func willSet(_ block: @escaping(_ newValue: Value, _ oldValue: Value) -> Void)
}

