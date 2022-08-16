//
//  CodeInitableViewController.swift
//  UtilsExample
//
//  Created by Николай on 16.08.2022.
//

import UIKit
import Utils

final class CodeInitableViewController: UIViewController, CodeInitable {

    private let initableLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        setupLabel()
    }

    private func setupLabel() {
        view.addSubview(initableLabel)

        initableLabel.text = "Hello, i was inited by code"
        initableLabel.textColor = .black
        initableLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            initableLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            initableLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
