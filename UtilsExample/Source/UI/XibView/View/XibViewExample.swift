//
//  XibViewExample.swift
//  UtilsExample
//
//  Created by vitalii on 17.08.2022.
//

import Utils
import UIKit

class XibViewExample: XibView {
    
    @IBOutlet weak var label: UILabel!
    
    override func initSetup() {
        super.initSetup()
        
        label.backgroundColor = .white
    }
}
