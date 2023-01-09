//
//  UIViewController+Ext.swift
//  
//
//  Created by vitalii on 17.08.2022.
//
import UIKit

public extension UIViewController {
    static var className: String { String(describing: Self.self) }
}
