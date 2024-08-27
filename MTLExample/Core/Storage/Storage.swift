//
//  Storage.swift
//  MTLExample
//
//  Created by Lioz Balki on 26/08/2024.
//

import Foundation

class Storage<Target: NSObject>: NSObject {
   
    typealias Storage = NSMapTable<NSString, Target>
    
    fileprivate var storage: Storage = {
        .init(keyOptions: .strongMemory, valueOptions: .weakMemory)
    }()
  
    func contains(_ target: Target?) -> Bool {
        return get(target?.pointer ?? "") != nil
    }
    
    internal func set(_ target: Target?) {
        objc_sync_enter(storage); defer { objc_sync_exit(storage) }
        storage.setObject(target, forKey: target?.pointer.nsstringValue)
    }

    internal func get(_ pointer: String) -> Target? {
        objc_sync_enter(storage); defer { objc_sync_exit(storage) }
        return storage.object(forKey: pointer.nsstringValue)
    }

    internal func remove(_ target: Target?) {
        objc_sync_enter(storage); defer { objc_sync_exit(storage) }
        storage.removeObject(forKey: target?.pointer.nsstringValue)
    }

    internal func forEach(_ body: (Target?) -> Void) {
        self.storage.forEach { body($0 as? Target) }
    }
}

extension NSMapTable {
    @objc func forEach(_ body: (Any?) -> Void) {
        objectEnumerator()?.allObjects.forEach {
            body($0)
        }
    }
}




