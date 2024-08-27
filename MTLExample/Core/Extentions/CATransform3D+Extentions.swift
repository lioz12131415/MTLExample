//
//  CATransform3D+Extentions.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

extension CATransform3D {
    internal static func rotation(degrees: Double, scale: CGFloat) -> CATransform3D {
        let radians   = CGFloat(degrees * Double.pi / 180)
        let rotation  = CATransform3DMakeRotation(radians, 0.0, 0.0, 1.0)
        let transform = CATransform3DScale(rotation, scale, scale, scale)
        return transform
    }
}

