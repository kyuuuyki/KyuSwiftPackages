//
//  UserService.swift
//  KyuNetworkExtensionsTests
//
//  Created by Chayanon Ardkham on 15/1/21.
//

import Foundation
import Moya
import ObjectMapper

enum UserAPITarget {
    case getUser(id: String)
    case getUsers
}

// MARK: - MOYA
extension UserAPITarget: TargetType {
    
    var baseURL: URL {
        return URL(string: AppConstant.URL.applicationAPIBaseUrl + "/users")!
    }
    
    var path: String {
        switch self {
        case .getUser(let id):
            return "/\(id)"
        case .getUsers:
            return ""
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var method: Moya.Method {
        switch self {
        case .getUser, .getUsers:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getUser, .getUsers:
            return .requestPlain
        }
    }
}
