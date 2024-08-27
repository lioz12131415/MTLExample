//
//  Metal.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

final class Metal {
    
    typealias Observation = NSKeyValueObservation
    
    fileprivate var origin:      UIImage?     = nil
    fileprivate var observation: Observation? = nil
    
    fileprivate weak var target: UIImageView? = nil {
        didSet { }
    }
    
    internal lazy var filters: MTLFilters? = {
        return MTLFilters(target, origin)
    }()
    
    internal init(target: UIImageView? = nil) {
        self.target = target
        self.origin = target?.image
        self.observe()
    }
    
    fileprivate func observe() {
        observation = target?.observe(\.image, options: [.new]) { [weak self] object, change in
            guard let new = change.newValue,
                  let old = change.oldValue, new != old else {
                return
            }
            if new?.isOrigin ?? true {
                self?.origin = new
                self?.filters = MTLFilters(self?.target, new)
            }
        }
    }
}
