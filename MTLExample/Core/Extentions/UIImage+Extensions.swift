//
//  UIImage+Extensions.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

extension UIImage {
    internal func writeToSavedPhotosAlbum(_ target: Any?, selector: Selector?) {
        UIImageWriteToSavedPhotosAlbum(self, target, selector, nil)
    }
}

extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension UIImage {
    internal func copy() -> UIImage? {
        guard let originalCgImage = self.cgImage, let newCgImage = originalCgImage.copy() else {
            return nil
        }
        return UIImage(cgImage: newCgImage, scale: self.scale, orientation: self.imageOrientation)
    }
}

extension UIImage {
    internal func colors(afterResizingTo size: CGSize = CGSize(width: 10, height: 10)) -> [UIColor] {
        guard let resizedImage = self.resize(to: size),
              let cgImage = resizedImage.cgImage else {
            return []
        }

        let width  = cgImage.width
        let height = cgImage.height
        
        let bytesPerPixel    = 4
        let bytesPerRow      = bytesPerPixel * width
        let bitsPerComponent = 8

        guard let colorSpace = cgImage.colorSpace else {
            return []
        }

        var rawData = [UInt8](repeating: 0, count: height * bytesPerRow)
        guard let context = CGContext(data: &rawData,
                                      width: width,
                                      height: height,
                                      bitsPerComponent: bitsPerComponent,
                                      bytesPerRow: bytesPerRow,
                                      space: colorSpace,
                                      bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            return []
        }

        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

        var uniqueColors: Set<UIColor> = []

        for y in 0..<height {
            for x in 0..<width {
                let pixelIndex = (y * bytesPerRow) + (x * bytesPerPixel)
                let red = rawData[pixelIndex]
                let green = rawData[pixelIndex + 1]
                let blue = rawData[pixelIndex + 2]
                let alpha = rawData[pixelIndex + 3]

                if alpha > 0 {
                    let color = UIColor(red:   CGFloat(red) / 255.0,
                                        green: CGFloat(green) / 255.0,
                                        blue:  CGFloat(blue) / 255.0,
                                        alpha: CGFloat(alpha) / 255.0)
                    uniqueColors.insert(color)
                }
            }
        }
        return Array(uniqueColors)
    }
}

