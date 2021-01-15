//
//  User.swift
//  KyuNetworkExtensionsTests
//
//  Created by Chayanon Ardkham on 15/1/21.
//

import Foundation
import ObjectMapper

class User: Mappable {
    
    var id: Int!
    var email: String?
    var firstName: String?
    var lastName: String?
    var avatar: String?
    
    //Init
    init() {}
    required init?(map: Map) {}
    
    //Map
    func mapping(map: Map) {
        id <- map["id"]
        email <- map["email"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        avatar <- map["avatar"]
    }
}
