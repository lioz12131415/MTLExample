//
//  MTLTexture+Extensions.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import MetalKit
import Foundation

extension MTLTexture {
    internal func descriptor(format: MTLPixelFormat, mipmapped: Bool = false) -> MTLTextureDescriptor {
        return MTLTextureDescriptor.texture2DDescriptor(pixelFormat: format,
                                                        width: width, height: height, mipmapped: false)
    }
}
