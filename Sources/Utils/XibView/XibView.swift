//
//  XibView.swift
//  Utils
//
//  Created by vitalii on 17.08.2022.
//

import UIKit

open class XibView: View, XibInitable {
    
    open var view: UIView?
    
    open override func initSetup() {
        super.initSetup()
        
        layoutView()
    }
    
    public static func initiate() -> Self {
        return self.init(fromCodeWithFrame: .zero)
    }
    
    private func layoutView() {
        guard let view = view else { return }
        
        insertSubview(view, at: .zero)
        layoutSubview(view)
    }
}
