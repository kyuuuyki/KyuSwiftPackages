//
//  +UIColor.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 24/8/18.
//

import Foundation
import UIKit

// MARK: - Initialization
extension UIColor {
    
    ///Init UIColor with Hexadecimal.
    public convenience init(hexadecimal: String) {
        
        var trimmedHexadecimal = hexadecimal.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (trimmedHexadecimal.hasPrefix("#")) {
            
            trimmedHexadecimal.remove(at: trimmedHexadecimal.startIndex)
        }
        
        if ((trimmedHexadecimal.count) > 6) {
            
            self.init(white: 1, alpha: 1)
        }
        else {
            
            while trimmedHexadecimal.count < 6 {
                
                trimmedHexadecimal = "0" + trimmedHexadecimal
            }
            
            var rgbValue: UInt64 = 0
            Scanner(string: trimmedHexadecimal).scanHexInt64(&rgbValue)
            
            let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
            
            self.init(red: red, green: green, blue: blue, alpha: 1)
        }
    }
}

// MARK: - Adjust Color Brightness
extension UIColor {
    
    ///Check if UIColor is dark or light color.
    public var isDarkColor: Bool {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let luminance = 0.2126 * red + 0.7152 * green + 0.0722 * blue
        
        return luminance < 0.5
    }
    
    ///Lighter UIColor.
    public func lighter(percentage: CGFloat = 30.0) -> UIColor? {
        
        return adjust(percentage: abs(percentage) )
    }
    
    ///Darker UIColor.
    public func darker(percentage: CGFloat = 30.0) -> UIColor? {
        
        return adjust(percentage: -1 * abs(percentage) )
    }
    
    ///Adjust UIColor brightness.
    public func adjust(percentage: CGFloat = 30.0) -> UIColor? {
        
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        
        if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        }
        else {
            
            return nil
        }
    }
}

// MARK: - Color to Image
extension UIColor {
    
    ///Get image from Color.
    public func toImage(rect: CGRect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)) -> UIImage {
        UIGraphicsBeginImageContext(rect.size)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        
        context.setFillColor(cgColor);
        context.fill(rect);
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return UIImage()
        }
        
        UIGraphicsEndImageContext();
        
        return image;
    }
}

// MARK: - Get Color
extension UIColor {
    
    ///Get Reverse UIColor.
    public func reverse() -> UIColor {
        
        let ciColor = CIColor(color: self)
        
        let red: CGFloat = 1.0 - ciColor.red
        let green: CGFloat = 1.0 - ciColor.green
        let blue: CGFloat = 1.0 - ciColor.blue
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    ///Get RGBA from UIColor.
    public var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        
        let coreImageColor = CIColor(color: self)
        
        return (coreImageColor.red, coreImageColor.green, coreImageColor.blue, coreImageColor.alpha)
    }
    
    ///Get Color in range from self to other Color.
    public func getColorInRange(toColor: UIColor, percent: Double) -> UIColor {
        
        let startRed = components.red
        let startGreen = components.green
        let startBlue = components.blue
        
        let endRed = toColor.components.red
        let endGreen = toColor.components.green
        let endBlue = toColor.components.blue
        
        var newRed = (endRed - startRed) * CGFloat(percent / 100)
        newRed = newRed + startRed
        
        var newGreen = (endGreen - startGreen) * CGFloat(percent / 100)
        newGreen = newGreen + startGreen
        
        var newBlue = (endBlue - startBlue) * CGFloat(percent / 100)
        newBlue = newBlue + startBlue
        
        return UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: 1)
    }
}
