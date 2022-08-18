//
//  UIDevice+Ext.swift
//  
//
//  Created by vitalii on 17.08.2022.
//

import UIKit

public extension UIDevice {
    
    static var hasNotch: Bool { (UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? .zero) > .zero }
}
