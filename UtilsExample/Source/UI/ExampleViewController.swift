//
//  ExampleViewController.swift
//  UtilsExample
//
//  Created by Николай on 16.08.2022.
//

import UIKit

final class ExampleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let BundleFileReader = BundleFileReaderExample()
        BundleFileReader.dataEncodingExample()
        BundleFileReader.dictionaryEncodingExample()
        BundleFileReader.jsonArrayEncodingExample()
    }

    @IBAction private func openXibInitableTap() {
        let xibController = XibInitableViewController.initiate()

        navigationController?.pushViewController(xibController, animated: true)
    }

    @IBAction func openCodeInitableControllerTap() {
        let codeController = CodeInitableViewController.initiate()
    
        navigationController?.pushViewController(codeController, animated: true)
    }
}
