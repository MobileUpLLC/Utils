//
//  XibView.swift
//  Utils
//
//  Created by vitalii on 17.08.2022.
//

import UIKit

open class XibView: View, XibInitable {
    
    open var view: UIView?
    
    static private var nibCache: [String: UINib] = [:]
    
    open override func initSetup() {
        super.initSetup()
        
        checkViewFromNib()
    }
    
    public static func initiate() -> Self {
        return self.init(fromCodeWithFrame: .zero)
    }
    
    private func layoutView() {
        guard let view = view else { return }
        
        insertSubview(view, at: 0)
        layoutSubview(view)
    }
    
    private func checkViewFromNib() {
        if let viewFromNib = loadViewFromNib() {
            view = viewFromNib
            layoutView()
        } else {
            view = self
        }
    }
    
    private func loadViewFromNib() -> UIView? {
        let nibName = Self.xibName
        var nib: UINib? = XibView.nibCache[nibName]
        
        if nib == nil {
            nib = UINib(nibName: nibName, bundle: Bundle(for: XibView.self))
            XibView.nibCache[nibName] = nib
        }
        
        return nib?.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
