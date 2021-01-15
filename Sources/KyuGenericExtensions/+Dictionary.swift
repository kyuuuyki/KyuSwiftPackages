//
//  +Dictionary.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 15/1/21.
//

import Foundation

// MARK: - Value for Nested Keys
extension Dictionary {
    
    /// Get Nested Value at specific path separated by ".".
    public func nestedValue(at path: String?) -> Any? {
        guard let path = path else { return self }
        
        let nestedKeys = path.components(separatedBy: ".")
        var nestedValue: Any?
        
        for nestedKey in nestedKeys {
            if let dictionary = self as? [String:Any], let innerNestedValue = dictionary[nestedKey] {
                nestedValue = innerNestedValue
            }
        }
        
        return nestedValue
    }
}
