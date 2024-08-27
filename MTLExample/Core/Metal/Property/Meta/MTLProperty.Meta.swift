//
//  MTLProperty.Meta.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import Foundation

extension MTLProperty {
    final class Meta: Equatable {

        private(set) var name:     String
        private(set) var saved:    Float
        private(set) var previous: Float
        
        init(value: Float, name: String) {
            self.name     = name
            self.saved    = value
            self.previous = value
        }
        
        internal func set(name: String) {
            self.name = name
        }
        
        internal func set(saved: Float) {
            self.saved = saved
        }
    
        internal func set(previous: Float) {
            self.previous = previous
        }
        
        internal static func == (lhs: MTLProperty.Meta, rhs: MTLProperty.Meta) -> Bool {
            return lhs.name == rhs.name
        }
    }
}
