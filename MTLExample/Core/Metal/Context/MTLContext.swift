//
//  MTLContext.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import MetalKit
import Foundation

final class MTLContext {
    
    private(set) var device:       MTLDevice?
    private(set) var commandQueue: MTLCommandQueue?
    
    internal init() {
        device       = MTLCreateSystemDefaultDevice()
        commandQueue = device?.makeCommandQueue()
    }
    
    internal func makeComputePipelineState(function name: String) -> MTLComputePipelineState? {
        let l = device?.makeDefaultLibrary()
        let f = l?.makeFunction(name: name)
        return try? device?.makeComputePipelineState(function: f!)
    }
}
