//
//  UIColor+Extensions.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

extension UIColor {
    internal convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red:   CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue:  CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
