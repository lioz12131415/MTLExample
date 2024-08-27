//
//  MTLProperty.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import Foundation

struct MTLProperty {
    
    @ObservableProperty private(set) var meta:  Meta
    @ObservableProperty private(set) var value: Float
    
    init(value: Float, name: String) {
        self.meta  = Meta(value: value, name: name)
        self.value = value
    }
    
    internal func save() {
        meta.set(saved: value)
    }
    
    internal func reverse() {
        guard value != meta.saved else { return }
        self.value = meta.saved
    }
    
    internal func set(_ newName: String) {
        guard newName != meta.name else { return }
        self.meta.set(name: newName)
    }
    
    internal func set(_ newValue: Float) {
        guard newValue != value else { return }
        self.meta.set(previous: value)
        self.value = newValue
    }
}
