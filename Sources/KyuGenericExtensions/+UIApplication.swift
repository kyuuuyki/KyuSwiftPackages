//
//  +UIApplication.swift
//  KyuGenericExtensions
//
//  Created by Chayanon Ardkham on 19/9/20.
//

import Foundation
import UIKit

// MARK: - Application's version info
extension UIApplication {
    
    ///Current application.
    public static func application() -> UIApplication {
        return UIApplication.shared
    }
    
    ///Version number.
    public var versionNumber: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    ///Build number.
    public var buildNumber: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
}

// MARK: - Application's window
extension UIApplication {
    
    ///Current window.
    public var window: UIWindow? {
        return UIApplication.application().delegate?.window ?? nil
    }
}
