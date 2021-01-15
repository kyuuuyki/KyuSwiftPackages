//
//  +String.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 23/8/18.
//

import Foundation
import UIKit

// MARK: - String to Date
extension String {
    
    ///Get Date from TimeString with configurable dateFormats. Already support ISO8601 formats.
    public func toDate(format: String = "", formats: [String] = [String](), calendar: Calendar = Calendar(identifier: .gregorian), timeZone: TimeZone = TimeZone(abbreviation: "UTC")!) -> Date? {
        
        //Date format list to try
        var dateFormats = ["yyyy-MM-dd'T'HH:mm:ssZ", "yyyy-MM-dd'T'HH:mm:ssZZZZZ", "yyyyMMdd'T'HHmmssZZZZZ", "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", "yyyy-MM-dd'T'HH:mm:ss.SSSZ", "yyyy-MM-dd"]
        dateFormats.append(contentsOf: formats)
        dateFormats.append(format)
        
        //Formatter
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.timeZone = timeZone
        
        for dateFormat in dateFormats {
            
            formatter.dateFormat = dateFormat
            
            if let date = formatter.date(from: self) {
                
                return date
            }
        }
        
        return nil
    }
}

// MARK: - String to QRCode Image
extension String {
    
    ///Get QRCode Image from String.
    public func toQRCodeImage(of size: CGSize, correctionLevel: String = "Q") -> UIImage? {
        
        let data = self.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue(correctionLevel, forKey: "inputCorrectionLevel")
        
        if let qrImage = filter?.outputImage {
            
            let scaleX = size.width / qrImage.extent.size.width
            let scaleY = size.height / qrImage.extent.size.height
            let scaledSize = CGAffineTransform(scaleX: scaleX, y: scaleY)
            let transformedQRImage = qrImage.transformed(by: scaledSize)
            
            let colorParameters = [
                "inputColor0": CIColor(color: .label), // Foreground
                "inputColor1": CIColor(color: .clear) // Background
            ]
            
            let coloredQRImage = transformedQRImage.applyingFilter("CIFalseColor", parameters: colorParameters)
            return UIImage(ciImage: coloredQRImage)
        }
        else {
            
            return nil
        }
    }
}

// MARK: - Check if String contains other String
extension String {
    
    ///Check if String contains other String.
    public func contains(string: String, insensitive: Bool = false) -> Bool{
        
        if insensitive {
            
            return range(of: string, options: .caseInsensitive) != nil
        }
        
        return range(of: string) != nil
    }
}

// MARK: - Split String by other String
extension String {
    
    ///Split String by other String.
    public func split(by: Set<String>) -> [String] {
        
        var string = ""
        var desiredOutput = [String]()
        
        for (_, ch) in self.enumerated() {
            
            if by.contains(String(ch)) {
                
                if !string.isEmpty {
                    
                    desiredOutput.append(string)
                }
                
                desiredOutput.append(String(ch))
                string = ""
            }
            else {
                
                string += String(ch)
            }
        }
        if !string.isEmpty {
            
            desiredOutput.append(string)
        }
        
        return desiredOutput
    }
}

// MARK: - Calculate width and height from String
extension String {
    
    ///Calculate height from String.
    public func height(width: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    ///Calculate width from String.
    public func width(height: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
