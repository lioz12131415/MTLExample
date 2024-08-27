//
//  Animations.PressOverlay.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

extension Animations {
    final class PressOverlay: NSObject {
        
        typealias Gesture = UILongPressGestureRecognizer
        
        fileprivate weak var target:  UIView?  = nil
        fileprivate lazy var overlay: CALayer? = nil
        fileprivate lazy var gesture: Gesture? = nil
        
        private(set) var duration:        CGFloat = 0.3
        private(set) var pressDuration:   CGFloat = 0.05
        private(set) var backgroundColor: CGColor = UIColor.clear.cgColor
        
        internal init(target: UIView? = nil) {
            self.target = target
        }
        
        internal func detach() {
            overlay?.removeAllAnimations()
            overlay?.removeFromSuperlayer()
            overlay = nil
            gesture = nil
        }
        
        internal func attach() {
            detach()
            overlay = CALayer()
            gesture = Gesture(target: self, action: #selector(press(_:)))
            
            overlay?.isHidden             = true
            gesture?.delegate             = self
            gesture?.delaysTouchesEnded   = true
            gesture?.delaysTouchesBegan   = true
            gesture?.cancelsTouchesInView = false
            
            overlay?.transform            = .rotation(degrees: -45, scale: 2.0)
            overlay?.backgroundColor      = backgroundColor
            gesture?.minimumPressDuration = pressDuration
            
            target?.layer.addSublayer(overlay!)
            target?.addGestureRecognizer(gesture!)
        }
        
        @discardableResult func set(duration: CGFloat) -> Self {
            self.duration = duration
            return self
        }
        
        @discardableResult func set(pressDuration: CGFloat) -> Self {
            self.pressDuration = pressDuration
            return self
        }
        
        @discardableResult func set(backgroundColor: CGColor) -> Self {
            self.backgroundColor = backgroundColor
            return self
        }
        
        fileprivate func animate(b: CGRect, w: CGFloat, h: CGFloat, s: Bool, sh: Bool, eh: Bool) {
            overlay?.frame.size = .init(width: w, height: h)
            overlay?.isHidden   = sh
            
            let endX   = s ? w/2 : -w
            let endY   = s ? h/2 : -h
            let startX = s ? w*2 : w/2
            let startY = s ? h*2 : h/2

            overlay?.transactions(
                CABasicAnimation.animate(from: startY, to: endY, duration: duration, key: "position.y"),
                CABasicAnimation.animate(from: startX, to: endX, duration: duration, key: "position.x")
            )
        }
        
        @objc
        fileprivate func press(_ gesture: UILongPressGestureRecognizer) {
            let b = target?.bounds ?? .zero
            let h = b.height
            let w = b.width
            
            switch gesture.state {
                case .began:     animate(b: b, w: w, h: h, s: true,  sh: false, eh: false)
                case .ended:     animate(b: b, w: w, h: h, s: false, sh: false, eh: true)
                case .failed:    animate(b: b, w: w, h: h, s: false, sh: false, eh: true)
                case .cancelled: animate(b: b, w: w, h: h, s: false, sh: false, eh: true)
            default:
                break
            }
        }
    }
}

extension Animations.PressOverlay: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        let other = otherGestureRecognizer
        let view  = otherGestureRecognizer.view
       
        if view is UIScrollView, other is UIPanGestureRecognizer, gestureRecognizer == gesture {
            return (otherGestureRecognizer.state != .possible || otherGestureRecognizer.state == .began)
        }
        return false
    }
}

extension CABasicAnimation {
    fileprivate static func animate(from: CGFloat, to: CGFloat, duration: CGFloat, key: String) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: key)
        animation.toValue   = to
        animation.fromValue = from
        
        animation.duration = duration
        animation.fillMode = .forwards
        
        animation.repeatCount           = 1
        animation.autoreverses          = false
        animation.isRemovedOnCompletion = false
        return animation
    }
}

