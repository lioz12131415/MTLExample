//
//  MTLNoirFilter.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

final class MTLNoirFilter: MTLFilter {
    
    private(set) var intensity = MTLProperty(value: 0.0, name: "intensity")
    
    override var properties: [MTLProperty] {
        return [intensity]
    }

    convenience init(_ context: MTLContext?) {
        self.init(function: "mtlnoir", context: context)
    }
    
    override func shouldProcess(input texture: MTLTexture?) -> Bool {
        return intensity.value != .zero
    }

    override func encode(to encoder: (any MTLComputeCommandEncoder)?) {
        var intensity = intensity.value
        encoder?.setBytes(&intensity, length: MemoryLayout<Float>.size, index: 0)
    }
}
