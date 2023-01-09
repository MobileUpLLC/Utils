//
//  CodeInitable.swift
//
//  Created by Николай on 16.08.2022.
//

import UIKit

public protocol CodeInitable: Initable { }

public extension CodeInitable where Self: UIViewController {
    static func initiate() -> Self {
        return Self()
    }
}

public extension CodeInitable where Self: UIView {
    static func initiate() -> Self {
        return Self()
    }
}
