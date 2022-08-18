//
//  Bundle+Ext.swift
//  
//
//  Created by vitalii on 17.08.2022.
//

import UIKit

public extension Bundle {
    
    static var appVersion: String {
        return main.infoDictionary?["CFBundleShortVersionString"] as? String ?? .empty
    }
    
    static var buildNumber: String {
        return main.infoDictionary?["CFBundleVersion"] as? String ?? .empty
    }
}
