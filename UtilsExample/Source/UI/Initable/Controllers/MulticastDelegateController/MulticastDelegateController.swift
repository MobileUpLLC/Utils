//
//  MulticastDelegateController.swift
//  UtilsExample
//
//  Created by vitalii on 07.10.2022.
//

import UIKit
import Utils

class MulticastDelegateController: UIViewController, CodeInitable {
    
    private let a = A()
    private let b = B()
    
    private let mulicastDelegate = MulticastDelegate<TestDelegate>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mulicastDelegate.add(delegate: a)
        mulicastDelegate.add(delegate: b)
        
        view.backgroundColor = .white
        
        setupButton()
    }
    
    private func invokeForEachDelegate() {
        mulicastDelegate.invokeForEachDelegate { delegate in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
            }
        }
    }
    
    private func setupButton() {
        let button = UIButton()
        button.setTitle("Press me to run delegates", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate(
            [
                button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
                button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
                button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]
        )
    }
    
    private func setupLabel() {
        
    }
    
    @objc func buttonTap() {
        print("done")
    }
}

private protocol TestDelegate: AnyObject {
    
    func test() -> String
}

private class A: TestDelegate {
    
    func test() -> String {
        return "This string from A class"
    }
}

private class B: TestDelegate {
    
    func test() -> String {
        return "This string from B class"
    }
}
