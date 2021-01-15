//
//  DefaultNetworkProvider.swift
//  KyuNetworkExtensions
//
//  Created by Chayanon Ardkham on 6/10/20.
//

import Foundation
import KyuGenericExtensions

import Moya
import ObjectMapper

public class DefaultNetworkProvider<T: TargetType> {
    
    private var provider: MoyaProvider<T>!
    private weak var configurator: DefaultNetworkProviderConfigurator?
    
    public convenience init(configurator: DefaultNetworkProviderConfigurator? = nil) {
        self.init()
        
        self.provider = MoyaProvider<T>()
        self.configurator = configurator
    }
    
    private func performRequest(route: T, success: @escaping (Response) -> Void, error: @escaping (Any) -> Void) {
        self.provider.request(route) { (result) in
            switch result {
            case let .success(response):
                success(response)
            case let .failure(err):
                error(err)
            }
        }
    }
    
    public func requestPlain(route: T, success: @escaping (Response) -> Void, error: @escaping (Any) -> Void) {
        if let configurator = configurator {
            configurator.requestPrerequisiteProcesses(completion: {
                self.performRequest(route: route, success: success, error: error)
            })
        }
        else {
            performRequest(route: route, success: success, error: error)
        }
    }
    
    public func requestObject<U: BaseMappable>(type: U.Type, nestedAt path: String? = nil, route: T, success: @escaping (U) -> Void, error: @escaping (Any) -> Void) {
        requestPlain(route: route, success: { (response) in
            if let path = path,
               let serializedJson = try? JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? Dictionary<String, Any>,
               let jsonObject = serializedJson.nestedValue(at: path) as? [String:Any],
               let serializedObject = Mapper<U>().map(JSONObject: jsonObject) {
                success(serializedObject)
                return
            } else if let jsonObject = try? JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? [String:Any],
                      let serializedObject = Mapper<U>().map(JSONObject: jsonObject) {
                success(serializedObject)
                return
            }
            error(response)
        }, error: { (err) in
            error(err)
        })
    }
    
    public func requestObjects<U: BaseMappable>(type: U.Type, nestedAt path: String? = nil, route: T, success: @escaping ([U]) -> Void, error: @escaping (Any) -> Void) {
        requestPlain(route: route, success: { (response) in
            if let path = path,
               let serializedJson = try? JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? Dictionary<String, Any>,
               let jsonObject = serializedJson.nestedValue(at: path) as? [[String:Any]],
               let serializedObjects = Mapper<U>().mapArray(JSONObject: jsonObject) {
                success(serializedObjects)
                return
            } else if let jsonObject = try? JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? [[String:Any]],
                      let serializedObjects = Mapper<U>().mapArray(JSONObject: jsonObject) {
                success(serializedObjects)
                return
            }
            error(response)
        }, error: { (err) in
            error(err)
        })
    }
}
