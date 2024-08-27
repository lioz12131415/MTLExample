//
//  CALayer+Extentions.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

extension CALayer {
    internal func transactions(_ a: CABasicAnimation,
                               _ b: CABasicAnimation, _ completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        
        add(a, forKey: a.keyPath)
        add(b, forKey: b.keyPath)
    
        CATransaction.commit()
    }
}

