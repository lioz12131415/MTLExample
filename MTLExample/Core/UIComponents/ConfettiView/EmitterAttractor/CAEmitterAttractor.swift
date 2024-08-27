//
//  CAEmitterAttractor.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

 final class CAEmitterAttractor: CAEmitterBehavior {
    
    convenience init() {
        self.init(type: "attractor")
        self.setValue("attractor", forKeyPath: "name")
    }
    
    @discardableResult func radius(_ newValue: NSNumber) -> Self {
        setValue(newValue, forKeyPath: "radius")
        return self
    }
    
    @discardableResult func falloff(_ newValue: NSNumber) -> Self {
        setValue(newValue, forKeyPath: "falloff")
        return self
    }
    
    @discardableResult func stiffness(_ newValue: NSNumber) -> Self {
        setValue(newValue, forKeyPath: "stiffness")
        return self
    }
    
    @discardableResult func z_position(_ newValue: NSNumber) -> Self {
        setValue(newValue, forKeyPath: "zPosition")
        return self
    }

    @discardableResult func position(x: CGFloat, y: CGFloat) -> Self {
        setValue(CGPoint(x: x, y: y), forKeyPath: "position")
        return self
    }
    
    internal func create() -> NSObject {
        return behavior
    }
}


