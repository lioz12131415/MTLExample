//
//  CAEmitterLayer+Extentions.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

extension CAEmitterLayer {
    func birthRate(_ animation: (d: CFTimeInterval, f: CGFloat, t: CGFloat)) {
        let a = CABasicAnimation()
        a.duration  = animation.d
        a.fromValue = animation.f
        a.toValue   = animation.t
        add(a, forKey: "birthRate")
    }
}

extension CAEmitterLayer {
    func attractor(_ animation: (d: CFTimeInterval, kt: [NSNumber], v: [NSNumber])) {
        let a = CAKeyframeAnimation()
        a.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        a.duration       = animation.d
        a.keyTimes       = animation.kt
        a.values         = animation.v
        add(a, forKey: "emitterBehaviors.attractor.stiffness")
    }
}

extension CAEmitterLayer {
    func dragAnimation(_ animation: (d: CFTimeInterval, f: CGFloat, t: CGFloat)) {
        let a = CABasicAnimation()
        a.duration  = animation.d
        a.fromValue = animation.f
        a.toValue   = animation.t
        add(a, forKey:  "emitterBehaviors.drag.drag")
    }
}
