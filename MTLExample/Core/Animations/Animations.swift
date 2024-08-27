//
//  Animations.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

final class Animations {
    
    fileprivate weak var target: UIView? = nil
    
    private(set) lazy var press: Press = {
        return Press(target: target)
    }()
    
    private(set) lazy var pressOverlay: PressOverlay = {
        return PressOverlay(target: target)
    }()
    
    internal init(_ target: UIView? = nil) {
        self.target = target
    }
}
