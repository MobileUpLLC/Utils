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
        static let labelText = "Accumulator is 0"
        static let labelPrefix = "Now accumulator is = "
        static let fontSize: CGFloat = 21
    }
    
    private let addTen = AddTen()
    private let addTwo = AddTwo()
    private let lable = UILabel()
    
    private let mulicastDelegate = MulticastDelegate<TestDelegate>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mulicastDelegate.add(delegate: addTen)
        mulicastDelegate.add(delegate: addTwo)
        
        view.backgroundColor = .white
        
        setupButton()
        setupLabel()
    }
    
    private func setupButton() {
        let button = UIButton(type: .system)
        button.setTitle(Constants.title, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        
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
        lable.font = .systemFont(ofSize: Constants.fontSize)
        lable.text = Constants.labelText
        lable.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lable)
        
        NSLayoutConstraint.activate(
            [
                lable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.horizontalInset),
                lable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: Constants.horizontalOffset),
                lable.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: Constants.yInset)
            ]
        )
    }
    
    @objc func buttonTap() {
        var accumulator: Int = .zero
        mulicastDelegate.invokeForEachDelegate { delegate in
            accumulator = delegate.test(accumulator: accumulator)
        }
        lable.text = Constants.labelPrefix + String(accumulator)
        
        mulicastDelegate.remove(delegate: addTen)
        mulicastDelegate.remove(delegate: addTwo)
    }
}

private protocol TestDelegate: AnyObject {
    
    func test(accumulator: Int) -> Int
}

private class AddTen: TestDelegate {
    
    private let baseAdd = 10
    
    func test(accumulator: Int) -> Int {
        return accumulator + baseAdd
    }
}

private class AddTwo: TestDelegate {
    
    private let baseAdd = 2
    
    func test(accumulator: Int) -> Int {
        return accumulator + baseAdd
    }
}
