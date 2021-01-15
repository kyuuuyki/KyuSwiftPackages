//
//  Defaults.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 23/8/18.
//

import Foundation
import UIKit

public class Defaults {
    
    private init() {}
    
    private static let shared = Defaults()
    public static func defaults() -> Defaults {
        return Defaults.shared
    }
    
    // MARK: - C
    public var calendar = Calendar(identifier: .gregorian)
    public var color = UIColor.link
    public var cornerRadius: CGFloat = 8
    
    // MARK: - D
    public var dateFormatInput: String = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    public var dateFormatOutput: String = "EEEE, d MMMM yyyy HH:mm:ss"
    
    // MARK: - L
    public var locale = Locale(identifier: "en_US_POSIX")
    
    // MARK: - N
    public var navigationBarBackgroundImage: UIImage?
    public var navigationBarShadowImage: UIImage?
    
    // MARK: - P
    public var padding: CGFloat = 20
    
    // MARK: - T
    public var timeZone = TimeZone(abbreviation: "UTC")!
}
