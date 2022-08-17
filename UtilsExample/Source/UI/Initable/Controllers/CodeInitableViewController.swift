//
//  CodeInitableViewController.swift
//  UtilsExample
//
//  Created by Николай on 16.08.2022.
//

import UIKit
import Utils

final class CodeInitableViewController: UIViewController, CodeInitable {

    private enum Constants {
        
        static let baseViewInset: CGFloat = 16
        static let baseViewOffset: CGFloat = -16
        static let formViewTopInset: CGFloat = 48
        static let formCodeViewHeight: CGFloat = 80
        static let formXibViewHeight: CGFloat = 130
        static let initableLabelText = "Hello, i was inited by code"
    }

    private lazy var initableLabel = UILabel()
    private lazy var formCodeView = FormCodeView.initiate()
    private lazy var formXibView = FormXibView.initiate()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        view.backgroundColor = .lightGray
        
        setupLabel()
        setupFormCodeView()
        setupFormXibView()
    }

    private func setupLabel() {
        view.addSubview(initableLabel)

        initableLabel.text = Constants.initableLabelText
        initableLabel.textColor = .black
        initableLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            initableLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            initableLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.baseViewInset)
        ])
    }

    private func setupFormCodeView() {
        view.addSubview(formCodeView)
        formCodeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            formCodeView.topAnchor.constraint(equalTo: initableLabel.topAnchor, constant: Constants.formViewTopInset),
            formCodeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.baseViewInset),
            formCodeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.baseViewOffset),
            formCodeView.heightAnchor.constraint(equalToConstant: Constants.formCodeViewHeight)
        ])
    }

    private func setupFormXibView() {
        view.addSubview(formXibView)
        formXibView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            formXibView.topAnchor.constraint(equalTo: formCodeView.bottomAnchor, constant: Constants.formViewTopInset),
            formXibView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.baseViewInset),
            formXibView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.baseViewOffset),
            formXibView.heightAnchor.constraint(equalToConstant: Constants.formXibViewHeight)
        ])
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
