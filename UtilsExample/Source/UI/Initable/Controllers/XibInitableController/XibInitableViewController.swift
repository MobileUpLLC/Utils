//
//  XibInitableViewController.swift
//  UtilsExample
//
//  Created by Николай on 16.08.2022.
//

import UIKit
import Utils

final class XibInitableViewController: UIViewController, XibInitable {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
    }
}
