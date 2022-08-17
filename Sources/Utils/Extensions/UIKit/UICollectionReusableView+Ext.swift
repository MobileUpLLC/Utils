//
//  UICollectionReusableView+Ext.swift
//  
//
//  Created by vitalii on 17.08.2022.
//

import UIKit

public extension UICollectionReusableView {
    
    static var reuseId: String { String(describing: Self.self) }
}
