//
//  +Mappable.swift
//  KyuNetworkExtensions
//
//  Created by Chayanon Ardkham on 8/10/20.
//

import Foundation

import ObjectMapper

extension Mappable {
    
    func duplicate<T: Mappable>() -> T? {
        return T(JSON: self.toJSON())
    }
}
