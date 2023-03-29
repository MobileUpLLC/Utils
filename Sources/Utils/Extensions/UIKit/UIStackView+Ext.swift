//
//  File.swift
//  
//
//  Created by Nikolai Timonin on 29.03.2023.
//

import UIKit

public extension UIStackView {
    convenience init(
        axis: NSLayoutConstraint.Axis,
        distribution: UIStackView.Distribution,
        alignment: UIStackView.Alignment,
        spacing: CGFloat = .zero,
        arrangedSubviews: [UIView] = []
    ) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
    
    func addArrangedSubview(view: UIView, spacingAfter: CGFloat) {
        addArrangedSubview(view)
        setCustomSpacing(spacingAfter, after: view)
    }
    
    func addArrangedSubviews(views: [UIView]) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
    
    func removeAllArangedSubviews() {
        arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
    }
}
