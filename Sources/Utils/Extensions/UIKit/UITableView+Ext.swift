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
    
    func registerXib(_ cellClass: UITableViewCell.Type) {
        let nib: UINib? = UINib(nibName: cellClass.reuseId, bundle: nil)
        guard let nib = nib else {
            fatalError("Не удалось найти Xib \(cellClass.reuseId)!")
        }
        
        register(nib, forCellReuseIdentifier: cellClass.reuseId)
    }
}
