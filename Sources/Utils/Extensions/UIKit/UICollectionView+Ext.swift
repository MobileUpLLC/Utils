//
//  UICollectionView+Ext.swift
//  
//
//  Created by vitalii on 17.08.2022.
//

import UIKit

public extension UICollectionView {
    private enum Constants {
        static let nibType: String = "nib"
    }
    
    func register(_ cellClass: UICollectionViewCell.Type) {
        if Bundle.main.path(forResource: cellClass.reuseId, ofType: Constants.nibType) == nil {
            register(cellClass, forCellWithReuseIdentifier: cellClass.reuseId)
        } else {
            register(UINib(nibName: cellClass.reuseId, bundle: .main), forCellWithReuseIdentifier: cellClass.reuseId)
        }
    }
}
