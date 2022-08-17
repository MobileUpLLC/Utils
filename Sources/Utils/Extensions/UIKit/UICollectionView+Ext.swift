//
//  UICollectionView+Ext.swift
//  
//
//  Created by vitalii on 17.08.2022.
//

import UIKit

public extension UICollectionView {
    
    func register(_ cellClass: UICollectionViewCell.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.reuseId)
    }
}
