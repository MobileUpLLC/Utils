//
//  MulticastDelegateTests.swift
//  UtilsExampleTests
//
//  Created by Виталий Вишняков on 09.11.2022.
//

import XCTest
import Utils

private protocol Delegate: AnyObject {
    func foo() -> String
}

private class A: Delegate {
    func foo() -> String {
        return "A"
    }
}

private class B: Delegate {
    func foo() -> String {
        return "B"
    }
}

private class C: Delegate {
    func foo() -> String {
        return "C"
    }
}

final class MulticastDelegateTests: XCTestCase {
    private let multicastDelegate = MulticastDelegate<Delegate>()
    
    private let a = A()
    private let b = B()
    private var c: C? = C()
    
    override func setUp() {
        super.setUp()
        multicastDelegate.add(delegate: a)
        multicastDelegate.add(delegate: b)
        if let c {
            multicastDelegate.add(delegate: c)
        }
    }
    
    override func tearDown() {
        super.tearDown()
        multicastDelegate.remove(delegate: a)
        multicastDelegate.remove(delegate: b)
        if let c {
            multicastDelegate.remove(delegate: c)
        }
    }
    
    func testMulticastDelegateInvoke() {
        multicastDelegate.invokeForEachDelegate { delegate in
            XCTAssertTrue(["A", "B", "C"].contains { delegate.foo() == $0 })
        }
    }
    
    func testMulticastDelegateNilObject() {
        c = nil
        
        multicastDelegate.invokeForEachDelegate { delegate in
            XCTAssertTrue(["A", "B"].contains { delegate.foo() == $0 })
        }
    }
}
