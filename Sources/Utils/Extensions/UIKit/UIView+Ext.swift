//
//  UIView+Ext.swift
//  
//
//  Created by vitalii on 17.08.2022.
//

import UIKit

public struct LayoutInsets {
    
    public static var zero: LayoutInsets { self.init(top: .zero, left: .zero, bottom: .zero, right: .zero) }
    
    public var top: CGFloat?
    public var left: CGFloat?
    public var bottom: CGFloat?
    public var right: CGFloat?
    
    public static func insets(
        top: CGFloat? = .zero,
        left: CGFloat? = .zero,
        bottom: CGFloat? = .zero,
        right: CGFloat? = .zero
    ) -> LayoutInsets {
        return LayoutInsets(top: top, left: left, bottom: bottom, right: right)
    }
}

public extension UIView {
    
    func layoutSubview(
        _ view: UIView,
        with insets: LayoutInsets = .zero,
        safe: Bool = false
    ) {
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = insets.top {
            view.topAnchor.makeConstraint(equalTo: getTopAnchor(safe: safe), constant: top)
        }
        
        if let left = insets.left {
            view.leadingAnchor.makeConstraint(equalTo: getLeadingAnchor(safe: safe), constant: left)
        }
        
        if let bottom = insets.bottom {
            view.bottomAnchor.makeConstraint(equalTo: getBottomAnchor(safe: safe), constant: -bottom)
        }
        
        if let right = insets.right {
            view.trailingAnchor.makeConstraint(equalTo: getTrailingAnchor(safe: safe), constant: -right)
        }
    }
    
    func layoutSubview(
        _ view: UIView,
        with insets: LayoutInsets = .zero,
        topSafe: Bool = false,
        leftSafe: Bool = false,
        bottomSafe: Bool = false,
        rightSafe: Bool = false
    ) {
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = insets.top {
            view.topAnchor.makeConstraint(equalTo: getTopAnchor(safe: topSafe), constant: top)
        }
        
        if let left = insets.left {
            view.leadingAnchor.makeConstraint(equalTo: getLeadingAnchor(safe: leftSafe), constant: left)
        }
        
        if let bottom = insets.bottom {
            view.bottomAnchor.makeConstraint(equalTo: getBottomAnchor(safe: bottomSafe), constant: -bottom)
        }
        
        if let right = insets.right {
            view.trailingAnchor.makeConstraint(equalTo: getTrailingAnchor(safe: rightSafe), constant: -right)
        }
    }
    
    func layoutSize(
        height: CGFloat? = nil,
        width: CGFloat? = nil,
        translateAutoresizingMaskIntoConstraints: Bool = false
    ) {
        translatesAutoresizingMaskIntoConstraints = translateAutoresizingMaskIntoConstraints
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
    func layoutCenter(_ view: UIView, xOffset: CGFloat = .zero, yOffset: CGFloat = .zero) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.centerXAnchor.constraint(equalTo: centerXAnchor, constant: xOffset).isActive = true
        view.centerYAnchor.constraint(equalTo: centerYAnchor, constant: yOffset).isActive = true
    }
    
    func getTopAnchor(safe: Bool) -> NSLayoutYAxisAnchor {
        return safe ? safeAreaLayoutGuide.topAnchor : topAnchor
    }
    
    func getBottomAnchor(safe: Bool) -> NSLayoutYAxisAnchor {
        return safe ? safeAreaLayoutGuide.bottomAnchor : bottomAnchor
    }
    
    func getLeadingAnchor(safe: Bool) -> NSLayoutXAxisAnchor {
        return safe ? safeAreaLayoutGuide.leadingAnchor : leadingAnchor
    }
    
    func getTrailingAnchor(safe: Bool) -> NSLayoutXAxisAnchor {
        return safe ? safeAreaLayoutGuide.trailingAnchor : trailingAnchor
    }
}

public extension NSLayoutAnchor {
    
    @objc func makeConstraint(equalTo anchor: NSLayoutAnchor, constant: CGFloat) {
        constraint(equalTo: anchor, constant: constant).isActive = true
    }
}
