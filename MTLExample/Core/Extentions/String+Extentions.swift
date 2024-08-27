//
//  String+Extentions.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import Foundation

extension String {
    internal static var empty: String {
        return ""
    }
}

extension String {
    internal var nsstringValue: NSString {
        return self as NSString
    }
}

