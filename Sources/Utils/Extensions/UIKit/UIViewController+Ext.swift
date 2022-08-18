//
//  UIViewController+Ext.swift
//  
//
//  Created by vitalii on 17.08.2022.
//
import UIKit

public extension UIViewController {
    
    var isHiddenTabBar: Bool {
        get { tabBarController?.tabBar.isHidden ?? true }
        set(value) { tabBarController?.tabBar.isHidden = value }
    }
    
    static var className: String { String(describing: Self.self) }
}
