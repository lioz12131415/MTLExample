//
//  MTLFilters.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

fileprivate var initialKey: UInt8 = 0

final class MTLFilters: NSObject {
    
    typealias Operations   = OperationQueue
    typealias Blur         = MTLBlurFilter
    typealias Noir         = MTLNoirFilter
    typealias Sharpen      = MTLSharpenFilter
    typealias Vignette     = MTLVignetteFilter
    typealias Brightness   = MTLBrightnessFilter
    typealias Quantization = MTLQuantizationFilter
    
    fileprivate var chain:   MTLChain? = nil
    fileprivate var current: CGImage?  = nil
    
    fileprivate weak var origin: UIImage?     = nil
    fileprivate weak var target: UIImageView? = nil
    
    fileprivate lazy var context:    MTLContext    = MTLContext()
    fileprivate lazy var operations: MTLOperations = MTLOperations()
    
    private(set) lazy var noir         = Noir(context)
    private(set) lazy var blur         = Blur(context)
    private(set) lazy var sharpen      = Sharpen(context)
    private(set) lazy var vignette     = Vignette(context)
    private(set) lazy var brightness   = Brightness(context)
    private(set) lazy var quantization = Quantization(context)
    
    internal var source: UIImage? {
        return origin?.copy()
    }
    
    internal var filtered: UIImage? {
        return UIImage(processed: current)
    }
    
    fileprivate lazy var filters: [MTLFilter] = [
        blur, noir, sharpen, vignette, brightness, quantization
    ]
    
    internal init?(_ target: UIImageView?, _ origin: UIImage?) {
        guard let target = target,
              let origin = origin else {
            return nil
        }
        super.init()
        self.origin = origin
        self.target = target
        self.filters.flatMap { $0.properties }.forEach {
            $0.$value.observe(self).didSet { [weak self] _, _ in self?.reload() }
        }
    }
    
    fileprivate func reload() {
        chain = nil
        chain = MTLChain(context, origin)
        
        operations.kill()
        operations.operation(of: filters, chain: chain) { [weak self] cgImage in
            self?.chain         = nil
            self?.current       = cgImage
            self?.target?.image = UIImage(processed: cgImage)
        }
    }
}

extension UIImage {
    fileprivate convenience init?(processed: CGImage?) {
        guard let processed = processed else {
            return nil
        }
        self.init(cgImage: processed)
        self.isOrigin(false)
    }
}

extension UIImage {
    fileprivate func isOrigin(_ newValue: Bool) {
        return withUnsafePointer(to: &initialKey) { [weak self] in
            guard let self else {
                return
            }
            objc_setAssociatedObject(self, $0, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}

extension UIImage {
    internal var isOrigin: Bool {
        return withUnsafePointer(to: &initialKey) { [weak self] in
            guard let self else {
                return true
            }
            return objc_getAssociatedObject(self, $0) as? Bool ?? true
        }
    }
}



