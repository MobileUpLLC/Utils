//
//  Button.swift
//  
//
//  Created by vitalii on 19.08.2022.
//

import UIKit

open class Button: UIButton {
    
    open override var isHighlighted: Bool { didSet { updateHighlighted() } }
    open override var isSelected: Bool { didSet { updateSelected() } }
    open override var isEnabled: Bool { didSet { updateEnabled() } }
    
    @IBInspectable open var normalColor: UIColor? { didSet { backgroundColor = normalColor } }
    @IBInspectable open var highlightedColor: UIColor?
    @IBInspectable open var selectedColor: UIColor?
    @IBInspectable open var disabledColor: UIColor?
    
    @IBInspectable open var normalTitleColor: UIColor? {
        didSet { setTitleColor(normalTitleColor, for: .normal) }
    }
    
    @IBInspectable open var disabledTitleColor: UIColor? {
        didSet { setTitleColor(disabledTitleColor, for: .disabled) }
    }
    
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
    
    private func initSetup(isForInterfaceBuilder: Bool) {
        clipsToBounds = false
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.minimumScaleFactor = .half
    }
    
    private func updateHighlighted() {
        guard isEnabled, isSelected == false, let highlightedColor = highlightedColor else {
            return
        }
        
        backgroundColor = isHighlighted ? highlightedColor : normalColor
    }
    
    private func updateEnabled() {
        guard let disabledColor = disabledColor else {
            return
        }
        
        backgroundColor = isEnabled ? normalColor : disabledColor
    }
    
    private func updateSelected() {
        guard isEnabled, let selectedColor = selectedColor else {
            return
        }
        
        backgroundColor = isSelected ? selectedColor : normalColor
    }
}
