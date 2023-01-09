//
//  UITableViewCell+Ext 2.swift
//  
//
//  Created by vitalii on 17.08.2022.
//

import UIKit

public extension UITableViewCell {
    static var reuseId: String { String(describing: Self.self) }
}
