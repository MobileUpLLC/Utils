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
    
    func registerXib(_ cellClass: UICollectionViewCell.Type) {
        let nib: UINib? = UINib(nibName: cellClass.reuseId, bundle: nil)
        guard let nib = nib else {
            fatalError("Не удалось найти Xib \(cellClass.reuseId)!")
        }

        register(nib, forCellWithReuseIdentifier: cellClass.reuseId)
    }
}
