//
//  UITableView+Ext.swift
//  
//
//  Created by vitalii on 17.08.2022.
//

import UIKit

public extension UITableView {
    
    private enum Constants {
        
        static let nibType: String = "nib"
    }
    
    func register(_ cellClass: UITableViewCell.Type) {
        if Bundle.main.path(forResource: cellClass.reuseId, ofType: Constants.nibType) == nil {
            register(cellClass, forCellReuseIdentifier: cellClass.reuseId)
        } else {
            register(UINib(nibName: cellClass.reuseId, bundle: .main), forCellReuseIdentifier: cellClass.reuseId)
        }
    }
}
