//
//  UITableView+Ext.swift
//  
//
//  Created by vitalii on 17.08.2022.
//

import UIKit

public extension UITableView {
    
    func register(_ cellClass: UITableViewCell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseId)
    }
}
