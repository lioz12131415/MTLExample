//
//  MTLFilter.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import MetalKit
import Foundation

class MTLFilter: NSObject {
    
    typealias Context  = MTLContext
    typealias Pipeline = MTLComputePipelineState
    
    fileprivate weak var context: Context?
    
    fileprivate var texture:       Texture?
    fileprivate var pipelineState: Pipeline?
    
    internal var properties: [MTLProperty] {
        return []
    }
    
    required init(function name: String, context: MTLContext?) {
        super.init()
        self.context       = context
        self.texture       = Texture(filter: self, context: context)
        self.pipelineState = context?.makeComputePipelineState(function: name)
    }
    
    internal func outpu(for input: MTLTexture?) -> MTLTexture? {
        return texture?.outpu(for: input, with: pipelineState)
    }
    
    internal func encode(to encoder: MTLComputeCommandEncoder?) {
        /* override func */
    }
    
    internal func shouldProcess(input texture: MTLTexture?) -> Bool {
        return true /* override func */
    }
}

