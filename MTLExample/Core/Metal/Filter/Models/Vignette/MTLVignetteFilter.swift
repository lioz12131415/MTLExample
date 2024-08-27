//
//  MTLVignetteFilter.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

final class MTLVignetteFilter: MTLFilter {
    
    private(set) var radius    = MTLProperty(value: 0.5, name: "radius")
    private(set) var intensity = MTLProperty(value: 0.0, name: "intensity")
    
    override var properties: [MTLProperty] {
        return [intensity, radius]
    }

    convenience init(_ context: MTLContext?) {
        self.init(function: "mtlvignette", context: context)
    }
    
    override func shouldProcess(input texture: MTLTexture?) -> Bool {
        return intensity.value != .zero
    }

    override func encode(to encoder: (any MTLComputeCommandEncoder)?) {
        var radius    = radius.value
        var intensity = intensity.value
        encoder?.setBytes(&radius,    length: MemoryLayout<Float>.size, index: 0)
        encoder?.setBytes(&intensity, length: MemoryLayout<Float>.size, index: 1)
    }
}
