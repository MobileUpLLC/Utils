//
//  FormCodeView.swift
//  UtilsExample
//
//  Created by Чаусов Николай on 16.08.2022.
//

import UIKit
import Utils

final class FormCodeView: UIView, CodeInitable {
    private enum Constants {
        static let formLabelText = "Enter your phone number here"
        static let formPlaceholder = "+7-999-12-34-56"
        static let textFieldBorderWidth: CGFloat = 1
        static let textFieldCornerRadius: CGFloat = 8
        static let textFieldTopInset: CGFloat = 16
        static let textFieldHeight: CGFloat = 30
    }
    
    private let formLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.formLabelText
        label.textColor = .black
        
        return label
    }()
    
    private let formTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.formPlaceholder
        textField.backgroundColor = .white
        textField.layer.cornerRadius = Constants.textFieldCornerRadius
        textField.layer.borderWidth = Constants.textFieldBorderWidth
        textField.layer.borderColor = UIColor.black.cgColor
        
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(formLabel)
        addSubview(formTextField)
    
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        formLabel.translatesAutoresizingMaskIntoConstraints = false
        formTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            formLabel.topAnchor.constraint(equalTo: self.topAnchor),
            formLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            formLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            formTextField.topAnchor.constraint(equalTo: formLabel.bottomAnchor, constant: Constants.textFieldTopInset),
            formTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            formTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            formTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            formTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight)
        ])
    }    
}
