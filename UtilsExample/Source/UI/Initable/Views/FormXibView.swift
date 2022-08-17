//
//  FormXibView.swift
//  UtilsExample
//
//  Created by Чаусов Николай on 17.08.2022.
//

import UIKit
import Utils

final class FormXibView: UIView, XibInitable {
    
    private enum Constants {
        
        static let textFieldBorderWidth: CGFloat = 1
        static let textFieldCornerRadius: CGFloat = 8
    }
    
    @IBOutlet private weak var emailTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        emailTextField.backgroundColor = .white
       
        emailTextField.layer.cornerRadius = Constants.textFieldCornerRadius
        emailTextField.layer.borderColor = UIColor.black.cgColor
        emailTextField.layer.borderWidth = Constants.textFieldBorderWidth
    }
}
