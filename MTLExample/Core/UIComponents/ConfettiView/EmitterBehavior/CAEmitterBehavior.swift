//
//  CAEmitterBehavior.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

class CAEmitterBehavior: NSObject {
    
    private(set) var behavior: NSObject
    
    init(type: String) {
        self.behavior = .behaviorClassInstance(type)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        behavior.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forKeyPath keyPath: String) {
        behavior.setValue(value, forKeyPath: keyPath)
    }
}
