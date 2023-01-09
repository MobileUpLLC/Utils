//
//  MulticastDelegate.swift
//  
//
//  Created by vitalii on 07.10.2022.
//

import Foundation

private class Wrapper<T>: Hashable {
    weak var delegate: AnyObject?
    
    init(_ delegate: T) {
        self.delegate = delegate as AnyObject
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
    static func == (lhs: Wrapper<T>, rhs: Wrapper<T>) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}

open class MulticastDelegate<T> {
    private var delegates: [T] { wrappers.compactMap { $0.delegate as? T } }
    
    private var wrappers: Set<Wrapper<T>> = []
    
    public init() { }
    
    public func add(delegate: T) {
        removeEmptyWrappers()
        
        let wrapper = Wrapper(delegate)
        wrappers.insert(wrapper)
    }
    
    public func remove(delegate: T) {
        removeEmptyWrappers()
        
        guard let element = wrappers.first(where: { $0.delegate === (delegate as AnyObject) }) else {
            return
        }
        wrappers.remove(element)
    }
    
    public func invokeForEachDelegate(_ handler: (T) -> Void) {
        removeEmptyWrappers()
        
        delegates.forEach { handler($0) }
    }
    
    private func removeEmptyWrappers() {
        wrappers = wrappers.filter { $0.delegate != nil }
    }
}
