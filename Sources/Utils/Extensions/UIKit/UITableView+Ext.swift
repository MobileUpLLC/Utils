//
//  UITableView+Ext.swift
//  
//
//  Created by vitalii on 17.08.2022.
//

import UIKit

public extension UITableView {
    
    func register(_ cellClass: UITableViewCell.Type) {
        if Bundle.main.path(forResource: cellClass.reuseId, ofType: "nib") == nil {
            register(cellClass, forCellReuseIdentifier: cellClass.reuseId)
        } else {
            register(UINib(nibName: cellClass.reuseId, bundle: .main), forCellReuseIdentifier: cellClass.reuseId)
        }
    }
}
