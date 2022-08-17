//
//  ExampleViewController.swift
//  UtilsExample
//
//  Created by Николай on 16.08.2022.
//

import UIKit
import Utils

final class ExampleViewController: UIViewController {
    
    @IBOutlet private weak var closureTextFieldResultLabel: UILabel!
    @IBOutlet private weak var closureSliderResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }

    @IBAction private func openXibInitableTap() {
        let xibController = XibInitableViewController.initiate()

        navigationController?.pushViewController(xibController, animated: true)
    }

    @IBAction func openCodeInitableControllerTap() {
        let codeController = CodeInitableViewController.initiate()
    
        navigationController?.pushViewController(codeController, animated: true)
    }
    
    @IBAction private func openClosureControllerTap(_ sender: UIButton) {
        let xibContoller = ClosureExampleViewController.initiate()
        
        xibContoller.textFieldClosure = { [weak self] result in
            self?.closureTextFieldResultLabel.text = result
        }
        xibContoller.sliderClosure = { [weak self] result in
            self?.closureSliderResultLabel.text = String(result)
        }
        
        navigationController?.pushViewController(xibContoller, animated: true)
    }
    
    @IBAction func openXibViewTap() {
        let controller = XibViewViewControllerExample.initiate()
        
        navigationController?.pushViewController(controller, animated: true)
    }
}
