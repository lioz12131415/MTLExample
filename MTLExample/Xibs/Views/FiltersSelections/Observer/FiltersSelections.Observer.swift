//
//  FiltersSelections.Observer.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import UIKit
import Foundation

extension FiltersSelectionsView {
    final class Observer: FiltersSelectionsObserve {
        
        fileprivate var didSelectBlock: ((Filter) -> Void)? = nil
        
        internal func didSelect(_ filter: Filter) {
            didSelectBlock?(filter)
        }
        
        @discardableResult func didSelect(_ block: @escaping(_ filter: Filter) -> Void) -> Self {
            didSelectBlock = block
            return self
        }
    }
}

protocol FiltersSelectionsObserve {
    @discardableResult func didSelect(_ block: @escaping(_ filter: Filter) -> Void) -> Self
}
