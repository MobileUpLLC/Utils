//
//  XibView.swift
//  Utils
//
//  Created by vitalii on 17.08.2022.
//

import UIKit

open class XibView1: BaseView {

    var view: UIView?
    
    open override func initSetup() {
        super.initSetup()
        
        checkViewFromNib()
    }
    
    private func checkViewFromNib() {
        if let viewFromNib = loadViewFromNib() {
            view = viewFromNib
            layoutView()
        } else {
            view = self
        }
    }
    
    private func layoutView() {
        guard let view = view else {
            return
        }

        insertSubview(view, at: .zero)
        layoutSubview(view)
    }
    
    private func loadViewFromNib() -> UIView? {
        let nib: UINib? = UINib(nibName: Self.xibName, bundle: Bundle(for: XibView1.self))
        
        return nib?.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

extension XibView1: XibInitable {
    
    public static func initiate() -> Self {
        return self.init(fromCodeWithFrame: .zero)
    }
}
