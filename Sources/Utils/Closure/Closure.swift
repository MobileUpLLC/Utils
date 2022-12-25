//
//  File.swift
//  
//
//  Created by Николай on 16.08.2022.
//

import Foundation

public enum Closure {
    
    public typealias Void = (() -> Swift.Void)
    public typealias Boolean = ((Swift.Bool) -> Swift.Void)
    public typealias Int = ((Swift.Int) -> Swift.Void)
    public typealias UInt = ((Swift.UInt) -> Swift.Void)
    public typealias Float = ((Swift.Float) -> Swift.Void)
    public typealias Double = ((Swift.Double) -> Swift.Void)
    public typealias String = ((Swift.String) -> Swift.Void)
    public typealias URL = ((Foundation.URL) -> Swift.Void)
    // swiftlint: disable syntactic_sugar
    public typealias Array<T> = (([T]) -> Swift.Void)
    public typealias Generic<T> = ((T) -> Swift.Void)
}
