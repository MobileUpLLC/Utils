//
//  String+Ext.swift
//  
//
//  Created by vitalii on 17.08.2022.
//

import Foundation

public extension String {
    
    static var empty: Self { "" }
    static var space: Self { " " }
    static var comma: Self { "," }
    static var slash: Self { "/" }
    static var dot: Self { "." }
    
    func asDouble() -> Double? {
        return Double(self.replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: " ", with: ""))
    }
    
    func withoutSpaces() -> String {
        return String(self.filter { !" \t".contains($0) })
    }
    
    func withoutTralingSpaces() -> String {
        return self.replacingOccurrences(
            of: "\\s+$",
            with: "",
            options: .regularExpression,
            range: nil
        )
    }
    
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    func separated(by separator: String, every: Int) -> String {
        return enumerated()
            .map { $0.isMultiple(of: every) && ($0 != 0) ? "\(separator)\($1)" : String($1) }
            .joined()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
