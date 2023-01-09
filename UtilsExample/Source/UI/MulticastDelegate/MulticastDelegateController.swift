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
        static let horizontalOffset = -16.0
        static let horizontalInset = 16.0
        static let yInset = 50.0
        static let labelInitialText = "Accumulator is 0"
        static let labelPrefix = "Now accumulator is = "
        static let fontSize = 21.0
    }
    
    private let testFirstObject = TestFirstObject()
    private let testSecondObject = TestSecondObject()
    
    private lazy var accumulatorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.fontSize)
        label.text = Constants.labelInitialText
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var accumulatorButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.title, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showAccumulatorButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let multicastDelegate = MulticastDelegate<TestDelegate>()
    
    private var accumulator: Int = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        layoutViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        multicastDelegate.add(delegate: testFirstObject)
        multicastDelegate.add(delegate: testSecondObject)
    }
    
    private func layoutViews() {
        view.addSubview(accumulatorButton)
        NSLayoutConstraint.activate([
            accumulatorButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.horizontalInset),
            accumulatorButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: Constants.horizontalOffset),
            accumulatorButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
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
