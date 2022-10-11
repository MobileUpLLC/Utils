//
//  MulticastDelegateController.swift
//  UtilsExample
//
//  Created by vitalii on 07.10.2022.
//

import UIKit
import Utils

class MulticastDelegateController: UIViewController, CodeInitable {
    
    private enum Constants {
        
        static let title = "Press me to run delegates"
        static let horizontalOffset: CGFloat = -16
        static let horizontalInset: CGFloat = 16
        static let yInset: CGFloat = 50
        static let labelInitialText = "Accumulator is 0"
        static let labelPrefix = "Now accumulator is = "
        static let fontSize: CGFloat = 21
    }
    
    private let testFirstObject = TestFirstObject()
    private let testSecondObject = TestSecondObject()

    private let label = UILabel()
    
    private let multicastDelegate = MulticastDelegate<TestDelegate>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        multicastDelegate.add(delegate: testFirstObject)
        multicastDelegate.add(delegate: testSecondObject)
        
        setupButton()
        setupLabel()
    }
    
    private func setupButton() {
        let button = UIButton(type: .system)
        button.setTitle(Constants.title, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showAccumulatorViewTapped), for: .touchUpInside)
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate(
            [
                button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.horizontalInset),
                button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: Constants.horizontalOffset),
                button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ]
        )
    }
    
    private func setupLabel() {
        label.font = .systemFont(ofSize: Constants.fontSize)
        label.text = Constants.labelInitialText
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate(
            [
                label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.horizontalInset),
                label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: Constants.horizontalOffset),
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: Constants.yInset)
            ]
        )
    }
    
    @objc func showAccumulatorViewTapped() {
        var accumulator: Int = .zero
        
        multicastDelegate.invokeForEachDelegate { delegate in
            accumulator = delegate.test(accumulator: accumulator)
        }
        
        label.text = Constants.labelPrefix + String(accumulator)
        
        multicastDelegate.remove(delegate: testFirstObject)
        multicastDelegate.remove(delegate: testSecondObject)
    }
}

private protocol TestDelegate: AnyObject {
    
    func test(accumulator: Int) -> Int
}

private class TestFirstObject: TestDelegate {
    
    private let valueForAdd = 1
    
    func test(accumulator: Int) -> Int {
        return accumulator + valueForAdd
    }
}

private class TestSecondObject: TestDelegate {
    
    private let valueForAdd = 2
    
    func test(accumulator: Int) -> Int {
        return accumulator + valueForAdd
    }
}
