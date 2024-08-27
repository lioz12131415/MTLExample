//
//  NSObject+Extentions.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

extension NSObject {
    var pointer: String {
        return "\(Unmanaged.passUnretained(self).toOpaque())"
    }
}

extension NSObject {
    internal static var behavior: NSObject.Type {
        return NSClassFromString("CAEmitterBehavior") as! NSObject.Type
    }
}

extension NSObject {
    internal static var behaviorClass: (@convention(c) (Any?, Selector, Any?) -> NSObject) {
        let behaviorWithType = behavior.method(for: NSSelectorFromString("behaviorWithType:"))!
        return unsafeBitCast(behaviorWithType, to:(@convention(c)(Any?, Selector, Any?) -> NSObject).self)
    }
}

extension NSObject {
    internal static func behaviorClassInstance(_ type: String) -> NSObject {
        let behaviorWithType   = behavior.method(for: NSSelectorFromString("behaviorWithType:"))!
        let castedBehaviorType = unsafeBitCast(behaviorWithType, to:(@convention(c)(Any?, Selector, Any?) -> NSObject).self)
        return castedBehaviorType(behavior, NSSelectorFromString("behaviorWithType"), type)
    }
}
