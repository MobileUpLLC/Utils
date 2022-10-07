//
//  MulticastDelegateTestClasses.swift
//  UtilsExampleTests
//
//  Created by vitalii on 07.10.2022.
//

import Foundation

protocol Delegate: AnyObject {
    
    func foo() -> String
}

class A: Delegate {
    
    func foo() -> String {
        return "A"
    }
}

class B: Delegate {
    
    func foo() -> String {
        return "B"
    }
}

class C: Delegate {
    
    func foo() -> String {
        return "C"
    }
}
