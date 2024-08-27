//
//  OperationQueue+Extensions.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import Foundation

extension OperationQueue {
    internal convenience init(max count: Int) {
        self.init()
        self.maxConcurrentOperationCount = count
    }
}

