//
//  Bundle+Ext.swift
//  
//
//  Created by vitalii on 17.08.2022.
//

import Foundation

public extension Bundle {
    private enum Constants {
        static let bundleShortVersionString: String = "CFBundleShortVersionString"
        static let bundleVersionString: String = "CFBundleVersion"
    }
    
    static var appVersion: String {
        return main.infoDictionary?[Constants.bundleShortVersionString] as? String ?? .empty
    }
    
    static var buildNumber: String {
        return main.infoDictionary?[Constants.bundleVersionString] as? String ?? .empty
    }
}
