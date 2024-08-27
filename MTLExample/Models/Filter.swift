//
//  Filter.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import Foundation

struct Filter {
        
    internal let name: String
    internal let icon: String
    
    internal weak var mtlValue: MTLFilter? = nil {
        didSet { }
    }
    
    internal var properties: [MTLProperty] {
        return mtlValue?.properties ?? []
    }
    
    internal init(_ name: String, _ icon: String, _ mtlValue: MTLFilter?) {
        self.name     = name
        self.icon     = icon
        self.mtlValue = mtlValue
    }
    
    internal mutating func save() {
        for i in 0..<properties.count {
            self.properties[i].save()
        }
    }
    
    internal mutating func unsave() {
        for i in 0..<properties.count {
            self.properties[i].reverse()
        }
    }
}

extension Filter {
    internal static var empty: Filter {
        return Filter(.empty, .empty, nil)
    }
}
