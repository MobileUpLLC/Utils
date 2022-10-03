//
//  File.swift
//  
//
//  Created by Николай on 16.09.2022.
//

import Foundation

public struct CustomDebugAction {
    
    let title: String
    let handler: () -> Void
    
    public init(title: String, handler: @escaping () -> Void) {
        self.title = title
        self.handler = handler
    }
}
