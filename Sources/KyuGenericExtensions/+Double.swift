//
//  +Double.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 23/8/18.
//

import Foundation

// MARK: - Double to String
extension Double {
    
    ///Double to String by NumberFormatter.
    public func toString(format: NumberFormatter.Style) -> String {
        
        let formatter = NumberFormatter()
        formatter.locale = Defaults.defaults().locale
        formatter.numberStyle = format
        
        return formatter.string(from: self as NSNumber) ?? "-"
    }
}
