//
//  Animations.Press.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

extension Animations {
    final class Press: NSObject {
        
        typealias Gesture  = UILongPressGestureRecognizer
        typealias Animator = UIViewPropertyAnimator
        
        fileprivate weak var target: UIView? = nil
        
        fileprivate var gesture:  Gesture?  = nil
        fileprivate var animator: Animator? = nil
        
        private(set) var scale:         CGFloat = 1.0
        private(set) var duration:      CGFloat = 0.30
        private(set) var pressDuration: CGFloat = 0.05
        
        internal init(target: UIView? = nil) {
            self.target = target
        }
        
        internal func detach() {
            animator?.stopAnimation(true)
            animator = nil
            gesture  = nil
        }
        
        internal func attach() {
            detach()
            gesture  = Gesture(target: self, action: #selector(press(_:)))
            animator = Animator(duration: duration, dampingRatio: 0.5)
            
            gesture?.delegate             = self
            gesture?.cancelsTouchesInView = false
            gesture?.minimumPressDuration = pressDuration
            
            animator?.isInterruptible          = true
            gesture?.delaysTouchesEnded        = true
            gesture?.delaysTouchesBegan        = true
            animator?.isUserInteractionEnabled = true
            
            target?.addGestureRecognizer(gesture!)
        }
        
        @discardableResult func set(scale: CGFloat) -> Self {
            self.scale = scale
            return self
        }
        
        @discardableResult func set(duration: CGFloat) -> Self {
            self.duration = duration
            return self
        }
        
        @discardableResult func set(pressDuration: CGFloat) -> Self {
            self.pressDuration = pressDuration
            return self
        }
        
        fileprivate func animate(scale: CGFloat) {
            animator?.addAnimations { [weak self]  in
                guard let self else { return }
                target?.transform = CGAffineTransformMakeScale(scale, scale)
            }
            animator?.startAnimation()
        }
        
        @objc
        fileprivate func press(_ gesture: UILongPressGestureRecognizer) {
            switch gesture.state {
                case .began:     animate(scale: scale)
                case .ended:     animate(scale: 1.0)
                case .failed:    animate(scale: 1.0)
                case .cancelled: animate(scale: 1.0)
            default:
                break
            }
        }
    }
}

extension Animations.Press: UIGestureRecognizerDelegate {
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

