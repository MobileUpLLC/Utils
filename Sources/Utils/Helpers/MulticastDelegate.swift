//
//  MulticastDelegate.swift
//  
//
//  Created by vitalii on 07.10.2022.
//

import Foundation

open class MulticastDelegate<T> {
    
    private var delegates = NSHashTable<AnyObject>.weakObjects()
    
    public init() { }
    
    public func add(delegate: T) {
        delegates.add(delegate as AnyObject)
    }
    
    public func remove(delegate: T) {
        delegates.remove(delegate as AnyObject)
    }
    
    public func invokeForEachDelegate(_ handler: (T) -> ()) {
        delegates.allObjects
            .compactMap { $0 as? T }
            .forEach { handler($0) }
    }
}
