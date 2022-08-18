//
//  UICollectionView+Ext.swift
//  
//
//  Created by vitalii on 17.08.2022.
//

import UIKit

public extension UICollectionView {
    
    func register(_ cellClass: UICollectionViewCell.Type) {
        if Bundle.main.path(forResource: cellClass.reuseId, ofType: "nib") == nil {
            register(cellClass, forCellWithReuseIdentifier: cellClass.reuseId)
        } else {
            register(UINib(nibName: cellClass.reuseId, bundle: .main), forCellWithReuseIdentifier: cellClass.reuseId)
        }
    }
}
