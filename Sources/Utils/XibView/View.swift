//
//  View.swift
//  Utils
//
//  Created by vitalii on 17.08.2022.
//

import UIKit

public class View: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSetup()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        initSetup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public required init(fromCodeWithFrame frame: CGRect) {
        super.init(frame: frame)
        
        initSetup()
    }
    
    public func initSetup() { }
}
