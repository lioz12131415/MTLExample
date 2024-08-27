//
//  MTLOperations.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

final class MTLOperations {
        
    fileprivate var queue = OperationQueue(max: 1)
        
    internal func kill() {
        queue.cancelAllOperations()
    }
    
    internal func operation(of filters: [MTLFilter],
                            chain: MTLChain?, _ completion: @escaping(CGImage?) -> Void) {
        queue.addBarrierBlock {
            let current = chain?.apply(filters)
            DispatchQueue.main.sync { completion(current) }
        }
    }
}

