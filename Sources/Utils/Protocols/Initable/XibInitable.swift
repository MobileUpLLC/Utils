//
//  XibInitable.swift
//  
//
//  Created by Николай on 16.08.2022.
//

import UIKit

public protocol XibInitable: Initable {

    static var xibName: String { get }
}

public extension XibInitable {
    
    static var xibName: String {
        return String(describing: Self.self)
    }
}

public extension XibInitable where Self: UIViewController {
    
    static func initiate() -> Self {
        return Self(nibName: xibName, bundle: nil)
    }
}

public extension XibInitable where Self: UIView {

    static func initiate() -> Self {
        guard
            let instance = UINib(nibName: xibName, bundle: nil)
                .instantiate(withOwner: nil, options: nil)
                .first as? Self
        else {
            fatalError("Couldn't resolve xib: \(xibName) for view: \(Self.self)")
        }

        return instance
    }
}
