//
//  UIColor+Ext.swift
//  
//
//  Created by vitalii on 17.08.2022.
//
import UIKit

public extension UIColor {
    
    private enum Constants {
        
        static let componentMaxValue: Float = 255
    }
    
    var hexValue: String { getHex() }
    
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: String.grid, with: String.space)
        
        var rgb: UInt64 = .zero
        
        var rvalue: CGFloat = .zero
        var gvalue: CGFloat = .zero
        var bvalue: CGFloat = .zero
        var avalue: CGFloat = .one
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }
        
        if length == 6 {
            rvalue = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            gvalue = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            bvalue = CGFloat(rgb & 0x0000FF) / 255.0
        } else if length == 8 {
            rvalue = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            gvalue = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            bvalue = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            avalue = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            return nil
        }
        
        self.init(red: rvalue, green: gvalue, blue: bvalue, alpha: avalue)
    }
    
    private func getHex() -> String {
        guard let components = cgColor.components, components.count >= .three else {
            return .empty
        }
        
        let red = Float(components[.zero])
        let green = Float(components[.one])
        let blue = Float(components[.two])
        var alpha: Float = .one
        
        if components.count == .four {
            alpha = Float(components[.three])
        }
        
        let hex = String(
            format: "%02lX%02lX%02lX%02lX",
            lroundf(red * Constants.componentMaxValue),
            lroundf(green * Constants.componentMaxValue),
            lroundf(blue * Constants.componentMaxValue),
            lroundf(alpha * Constants.componentMaxValue)
        )
        
        return hex
    }
    
    convenience init(rgb: UInt32) {
        let iBlue = rgb & 0xFF
        let iGreen = (rgb >> 8) & 0xFF
        let iRed = (rgb >> 16) & 0xFF
        let iAlpha = (rgb >> 24) & 0xFF
        
        self.init(
            red: CGFloat(iRed) / 255,
            green: CGFloat(iGreen) / 255,
            blue: CGFloat(iBlue) / 255,
            alpha: CGFloat(iAlpha) / 255
        )
    }
}
