//
//  MTLFilter.Texture.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import MetalKit
import Foundation

extension MTLFilter {
    final class Texture {
                
        typealias PipelineState = MTLComputePipelineState
        
        fileprivate weak var filter:  MTLFilter?  = nil
        fileprivate weak var context: MTLContext? = nil
        
        fileprivate var device: MTLDevice? {
            return context?.device
        }
        
        fileprivate var commandQueue: MTLCommandQueue? {
            return context?.commandQueue
        }
        
        required init(filter: MTLFilter?, context: MTLContext?) {
            self.filter  = filter
            self.context = context
        }
        
        internal func outpu(for input: MTLTexture?, with pipelineState: PipelineState?) -> MTLTexture? {
            guard let device            = device,
                  let commandQueue      = commandQueue,
                  let pipelineState     = pipelineState,
                  let textureDescriptor = input?.descriptor(format: .rgba8Unorm) else {
                return nil
            }
            
            textureDescriptor.usage = [
                .shaderRead,
                .shaderWrite
            ]
            
            let output  = device.makeTexture(descriptor: textureDescriptor)
            let buffer  = commandQueue.makeCommandBuffer()
            let encoder = buffer?.makeComputeCommandEncoder()
            
            encoder?.setComputePipelineState(pipelineState)
            encoder?.setTexture(input,  index: 0)
            encoder?.setTexture(output, index: 1)
            
            filter?.encode(to: encoder)
            
            let w      = input?.width  ?? 0
            let h      = input?.height ?? 0
            let size   = MTLSize(width: 16, height: 16, depth: 1)
            
            let groups = MTLSize(width:  (w + size.width - 1)  / size.width,
                                 height: (h + size.height - 1) / size.height, depth: 1)
            
            encoder?.dispatchThreadgroups(groups, threadsPerThreadgroup: size)
            encoder?.endEncoding()
            
            buffer?.commit()
            buffer?.waitUntilCompleted()
            
            return output
        }
    }
}

