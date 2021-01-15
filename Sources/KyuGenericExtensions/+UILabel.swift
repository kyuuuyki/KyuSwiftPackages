//
//  +UILabel.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 24/8/18.
//

import Foundation
import UIKit

// MARK: - Set inversed-color for Text based on BackgroundColor
extension UILabel {
    
    ///Set inversed-color for Text based on BackgroundColor.
    public func setTextColor(forBackgroundColor: UIColor) {
        
        if forBackgroundColor.isDarkColor {
            
            textColor = UIColor.white
        }
        else {
            
            textColor = UIColor.black
        }
    }
}

// MARK: - Set inversed-color for BackgroundColor based on Text
extension UILabel {
    
    ///Set inversed-color for BackgroundColor based on Text.
    public func setBackgroundColor(forTextColor: UIColor) {
        
        if forTextColor.isDarkColor {
            
            backgroundColor = UIColor.white
        }
        else {
            
            backgroundColor = UIColor.black
        }
    }
}
