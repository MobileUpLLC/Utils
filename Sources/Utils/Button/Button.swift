//
//  Button.swift
//  
//
//  Created by vitalii on 19.08.2022.
//

import UIKit

class Button: UIButton {
    
    private enum Constants {
        
        static let defaultTitleEdgeInsets = UIEdgeInsets(top: .ten, left: .ten, bottom: .ten, right: .ten)
    }
    
    @IBInspectable var normalColor: UIColor? { didSet { backgroundColor = normalColor } }
    @IBInspectable var highlightedColor: UIColor?
    @IBInspectable var selectedColor: UIColor?
    @IBInspectable var disabledColor: UIColor?
    @IBInspectable var normalTitleColor: UIColor? { didSet { setTitleColor(normalTitleColor, for: .normal) } }
    @IBInspectable var disabledTitleColor: UIColor? { didSet { setTitleColor(disabledTitleColor, for: .disabled) } }
    
    override var isHighlighted: Bool { didSet { updateHighlighted() } }
    override var isSelected: Bool { didSet { updateSelected() } }
    override var isEnabled: Bool { didSet { updateEnabled() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSetup(isForInterfaceBuilder: false)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initSetup(isForInterfaceBuilder: false)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        initSetup(isForInterfaceBuilder: true)
    }
    
    convenience init() {
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
