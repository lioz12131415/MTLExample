//
//  ObservableProperty.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

@propertyWrapper
class ObservableProperty<Value: Equatable>: NSObject, Observable {
    
    fileprivate var value: Value! {
        didSet  {
            didSet(newValue: value, oldValue: oldValue)
        }
        willSet {
            willSet(newValue: newValue, oldValue: value)
        }
    }
    
    fileprivate lazy var storage: Storage<Observe> = {
        Storage<Observe>()
    }()
    
    internal var wrappedValue: Value {
        get { value }
        set { value = newValue }
    }
    
    internal var projectedValue: ObservableProperty<Value> {
        return self
    }
    
    internal init(wrappedValue: Value) {
        self.value = wrappedValue
    }
    
    internal func observe(_ target: NSObject) -> any ReciveablePropertyObserve<Value> {
        let observe = observe(for: target)
        if !storage.contains(observe) {
            storage.set(observe)
        }
        return observe
    }
    
    fileprivate func didSet(newValue: Value, oldValue: Value) {
        guard newValue != oldValue else {
            return
        }
        storage.forEach { $0?.didSet(newValue, oldValue) }
    }
    
    fileprivate func willSet(newValue: Value, oldValue: Value) {
        guard newValue != oldValue else {
            return
        }
        storage.forEach { $0?.willSet(newValue, oldValue) }
    }
}

