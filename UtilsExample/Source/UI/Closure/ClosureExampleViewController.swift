//
//  ClosureExampleViewController.swift
//  UtilsExample
//
//  Created by Николай on 16.08.2022.
//

import UIKit
import Utils

final class ClosureExampleViewController: UIViewController, XibInitable {

    private enum Constants {
        
        static let sliderBaseValue: Float = 50
        static let empty = ""
    }
    
    var textFieldClosure: Closure.String?
    var sliderClosure: Closure.Float?
    
    private var sliderInput: Float = Constants.sliderBaseValue

    @IBOutlet private var textField: UITextField!
    @IBOutlet private var closureLabel: UILabel!
    @IBOutlet private var sliderValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap) 
        
        view.backgroundColor = .white
    }

    @IBAction private func sliderDidChangeValue(_ sender: UISlider) {
        sliderInput = sender.value
        sliderValue.text = String(sender.value)
    }

    @IBAction private func applyDataButtonTap() {
        textFieldClosure?(textField.text ?? Constants.empty)
        sliderClosure?(sliderInput)
        
        navigationController?.popViewController(animated: true)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
