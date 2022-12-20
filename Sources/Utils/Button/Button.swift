//
//  Button.swift
//  
//
//  Created by vitalii on 19.08.2022.
//

import UIKit

open class Button: UIButton {
    
    private enum Constants {
        
        static let defaultTitleEdgeInsets = UIEdgeInsets(top: .ten, left: .ten, bottom: .ten, right: .ten)
    }
    
    @IBInspectable var normalColor: UIColor? { didSet { backgroundColor = normalColor } }
    @IBInspectable var highlightedColor: UIColor?
    @IBInspectable var selectedColor: UIColor?
    @IBInspectable var disabledColor: UIColor?
    @IBInspectable var normalTitleColor: UIColor? { didSet { setTitleColor(normalTitleColor, for: .normal) } }
    @IBInspectable var disabledTitleColor: UIColor? { didSet { setTitleColor(disabledTitleColor, for: .disabled) } }
    
    open override var isHighlighted: Bool { didSet { updateHighlighted() } }
    open override var isSelected: Bool { didSet { updateSelected() } }
    open override var isEnabled: Bool { didSet { updateEnabled() } }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSetup(isForInterfaceBuilder: false)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initSetup(isForInterfaceBuilder: false)
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        initSetup(isForInterfaceBuilder: true)
    }
    
    convenience public init() {
        self.init(type: .custom)
    }
    
    func initSetup(isForInterfaceBuilder: Bool) {
        clipsToBounds = false
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.minimumScaleFactor = .half
        titleEdgeInsets = Constants.defaultTitleEdgeInsets
    }
    
    func updateHighlighted() {
        guard isEnabled, isSelected == false, let highlightedColor = highlightedColor else {
            return
        }
        
        backgroundColor = isHighlighted ? highlightedColor : normalColor
    }
    
    func updateEnabled() {
        guard let disabledColor = disabledColor else {
            return
        }
        
        backgroundColor = isEnabled ? normalColor : disabledColor
    }
    
    func updateSelected() {
        guard isEnabled, let selectedColor = selectedColor else {
            return
        }
        
        backgroundColor = isSelected ? selectedColor : normalColor
    }
}
