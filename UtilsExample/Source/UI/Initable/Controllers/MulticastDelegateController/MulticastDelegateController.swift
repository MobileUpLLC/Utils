//
//  MulticastDelegateController.swift
//  UtilsExample
//
//  Created by vitalii on 07.10.2022.
//

import UIKit
import Utils

class MulticastDelegateController: UIViewController, XibInitable {
    
    private let a = A()
    private let b = B()
   
    private let mulicastDelegate = MulticastDelegate<TestDelegate>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
}

private protocol TestDelegate: AnyObject {
    
    func test()
}

private class A: TestDelegate {
    
    func test() {
        print("Class A")
    }
}

private class B: TestDelegate {
    
    func test() {
        print("Class B")
    }
}
