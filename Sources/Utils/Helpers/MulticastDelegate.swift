//
//  MulticastDelegate.swift
//  
//
//  Created by vitalii on 07.10.2022.
//

import Foundation

open class MulticastDelegate<T> {
    
    private class Wrapper {
        
        weak var delegate: AnyObject?
        
        init(_ delegate: AnyObject) {
            self.delegate = delegate
        }
    }
    
    public var delegates: [T] { wrappers.compactMap { $0.delegate } as! [T] }
    
    private var wrappers: [Wrapper] = []
    
    public init() { }
    
    public func add(delegate: T) {
        let wrapper = Wrapper(delegate as AnyObject)
        wrappers.append(wrapper)
    }
    
    public func remove(delegate: T) {
        guard let index = wrappers.firstIndex(where: { $0.delegate === (delegate as AnyObject) }) else {
            return
        }
        wrappers.remove(at: index)
    }
    
    public func invokeForEachDelegate(_ handler: (T) -> Void) {
        delegates.forEach { handler($0) }
    }
}
