//
//  AppService.swift
//  KyuNetworkExtensionsTests
//
//  Created by Chayanon Ardkham on 15/1/21.
//

import Foundation
import KyuNetworkExtensions

class AppService {
    
    private init() {}
    private static let shared = AppService()
    
    private static func appService() -> AppService {
        return self.shared
    }
    
    static func userService() -> DefaultNetworkProvider<UserAPITarget> {
        return DefaultNetworkProvider<UserAPITarget>()
    }
}
