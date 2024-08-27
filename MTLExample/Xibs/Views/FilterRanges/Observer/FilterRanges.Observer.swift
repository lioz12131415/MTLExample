//
//  FilterRanges.Observer.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

extension FilterRangesView {
    final class Observer: FilterRangesObserve {
        
        fileprivate var saveBlock:  (() -> Void)? = nil
        fileprivate var closeBlock: (() -> Void)? = nil
        
        internal func save() {
            saveBlock?()
        }
        
        internal func close() {
            closeBlock?()
        }
        
        @discardableResult func save(_ block: @escaping() -> Void) -> Self {
            saveBlock = block
            return self
        }
        
        @discardableResult func close(_ block: @escaping() -> Void) -> Self {
            closeBlock = block
            return self
        }
    }
}

protocol FilterRangesObserve {
    @discardableResult func save(_ block: @escaping() -> Void) -> Self
    @discardableResult func close(_ block: @escaping() -> Void) -> Self
}
