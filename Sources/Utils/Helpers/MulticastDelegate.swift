//
//  MulticastDelegate.swift
//  
//
//  Created by vitalii on 07.10.2022.
//

import Foundation

// Если объект, который был добавлен в NSHashTable, был удалён (равен nil),
// таблица будет хранить слабую ссылку, пока не будут вызыванны методы add или remove или invokeForEachDelegate
// https://developer.apple.com/documentation/foundation/nshashtable
// https://nshipster.com/nshashtable-and-nsmaptable/
open class MulticastDelegate<T> {
    
    private var delegates = NSHashTable<AnyObject>.weakObjects()
    
    public init() { }
    
    public func add(delegate: T) {
        delegates.add(delegate as AnyObject)
    }
    
    public func remove(delegate: T) {
        delegates.remove(delegate as AnyObject)
    }
    
    public func invokeForEachDelegate(_ handler: (T) -> Void) {
        delegates.allObjects
            .compactMap { $0 as? T }
            .forEach { handler($0) }
    }
}
