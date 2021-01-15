//
//  DefaultNetworkProviderConfigurator.swift
//  KyuNetworkExtensions
//
//  Created by Chayanon Ardkham on 6/10/20.
//

import Foundation

public protocol DefaultNetworkProviderConfigurator: class {
    func requestPrerequisiteProcesses(completion: @escaping () -> Void)
}

public extension DefaultNetworkProviderConfigurator {
    func requestPrerequisiteProcesses(completion: @escaping () -> Void) {
        completion()
    }
}
