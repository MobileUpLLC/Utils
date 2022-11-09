//
//  MulticastDelegateController.swift
//  UtilsExample
//
//  Created by vitalii on 07.10.2022.
//

import UIKit
import Utils

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
    
    private let accumulatorLabel = UILabel()
    
    private let multicastDelegate = MulticastDelegate<TestDelegate>()
    
    private var accumulator: Int = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupAccumulatorButton()
        setupAccumulatorLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        multicastDelegate.add(delegate: testFirstObject)
        multicastDelegate.add(delegate: testSecondObject)
    }
    
    private func setupAccumulatorButton() {
        let button = UIButton(type: .system)
        button.setTitle(Constants.title, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showAccumulatorButtonTapped), for: .touchUpInside)
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.horizontalInset),
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: Constants.horizontalOffset),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupAccumulatorLabel() {
        accumulatorLabel.font = .systemFont(ofSize: Constants.fontSize)
        accumulatorLabel.text = Constants.labelInitialText
        accumulatorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(accumulatorLabel)
        
        NSLayoutConstraint.activate([
            accumulatorLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.horizontalInset),
            accumulatorLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: Constants.horizontalOffset),
            accumulatorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: Constants.yInset)
        ])
    }
    
    @objc private func showAccumulatorButtonTapped() {
        multicastDelegate.invokeForEachDelegate { delegate in
            accumulator = delegate.test(accumulator: accumulator)
        }
        
        accumulatorLabel.text = Constants.labelPrefix + String(accumulator)
    }
}
