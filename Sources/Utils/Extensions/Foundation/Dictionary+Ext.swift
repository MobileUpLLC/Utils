//
//  Dictionary+Ext.swift
//  
//
//  Created by vitalii on 17.08.2022.
//

import Foundation

public extension Dictionary {
    mutating func setValue(_ value: Value?, forKey key: Key) {
       if let value = value {
           self[key] = value
       }
   }
}
