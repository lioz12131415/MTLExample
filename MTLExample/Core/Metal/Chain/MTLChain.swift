//
//  MTLChain.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import MetalKit
import Foundation

class MTLChain {
    
    fileprivate weak var origin:  UIImage?
    fileprivate weak var context: MTLContext?
    
    internal init(_ context: MTLContext, _ origin: UIImage?) {
        self.origin  = origin
        self.context = context
    }
    
    internal func apply(_ filters: [MTLFilter]) -> CGImage? {
        guard let cgImage = origin?.cgImage else {
            return nil
        }
        return process(filters, on: cgImage)
    }
    
    fileprivate func process(_ filters: [MTLFilter], on cgImage: CGImage) -> CGImage? {
        guard let device = context?.device else {
            return nil
        }
        let loader  = MTKTextureLoader(device: device)
        var texture = try? loader.newTexture(cgImage: cgImage, options: nil)
        
        for filter in filters where filter.shouldProcess(input: texture) {
            guard let output = filter.outpu(for: texture) else {
                continue
            }
            texture = output
        }
        
        guard let output  = texture,
              let ciImage = CIImage(mtlTexture: output, options: nil) else {
            return nil
        }
        let rect     = CGRect(x: 0, y: 0, width: output.width, height: output.height)
        let context  = CIContext(mtlDevice: device)
        let mirrored = ciImage.oriented(.downMirrored)
        
        return context.createCGImage(mirrored, from: rect)
    }
}

