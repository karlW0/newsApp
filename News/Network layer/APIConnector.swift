//
//  APIConnector.swift
//  News
//
//  Created by Ivan Depolo on 29/11/2018.
//  Copyright © 2018 Ivan Depolo. All rights reserved.
//

import Foundation
import Alamofire

private struct Constants {
    static let apiKey = "apiKey"
    static let systemApiKey = "API_KEY"
    
    static let everythingPath = "/everything"
    static let topPath        = "/top-headlines"
    static let sourcesPath    = "/sources"
    
    static let errorString    = "error"
    static let networkErorr   = "network error"
}

enum APIResult {
    case success([AnyHashable : Any])
    case error(String)
}

class APIConnector : NSObject, APIConnectable {
    internal let baseURL : String
    init(with baseURL : String) {
        self.baseURL = baseURL
    }
}

protocol APIConnectable : NewsConnectable {
    var baseURL : String { get }
}

protocol NewsConnectable {
    func getEverything(with parameters : [String : Any], completion : @escaping (APIResult) -> () )
    func getTopHeadlines( with parameters : [String : Any], completion : @escaping (APIResult) -> () )
    func getSources( with parameters : [String : Any], completion : @escaping (APIResult) -> () )
}

private enum Routes {
    case everything
    case top
    case sources
}

extension APIConnector: NewsConnectable{
    
    func getEverything(with parameters: [String : Any], completion: @escaping (APIResult) -> ()) {
        let route = getRoute(for: .everything)
        executeRequest(for: route, with: parameters) { (result) in
            completion(result)
        }
    }
    
    func getTopHeadlines( with parameters: [String : Any], completion: @escaping (APIResult) -> ()) {
        let route = getRoute(for: .top)
        executeRequest(for: route, with: parameters) { (result) in
            completion(result)
        }
    }

    func getSources(with parameters: [String : Any], completion: @escaping (APIResult) -> ()) {
        let route = getRoute(for: .sources)
        executeRequest(for: route, with: parameters) { (result) in
            completion(result)
        }
    }
    
    private func executeRequest( for route: String, with parameters: [String : Any], completion: @escaping (APIResult) -> () ) {
        guard
            let info = Bundle.main.infoDictionary,
            let key = info[Constants.systemApiKey] as? String
            else{
                return
        }
        var parametersWithKey = parameters
            parametersWithKey.updateValue(key, forKey: Constants.apiKey)
        request( route,
                 method: .get,
                 parameters: parametersWithKey,
                 encoding: URLEncoding.queryString,
                 headers: nil )
            .responseJSON { (response) in
                if response.result.isSuccess{
                    if let value = response.result.value as? [AnyHashable : Any]{
                        completion(.success(value))
                    }else{
                        completion(.error(Constants.networkErorr))
                    }
                } else {
                    if
                        let data = response.data,
                        let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String : String],
                        let jsonUnpacked = json,
                        let reason = jsonUnpacked[Constants.errorString] {
                        completion(.error(reason))
                    } else {
                        completion(.error(Constants.networkErorr))
                    }
                }
                
        }
    }
    
    private func getRoute(for endpoint: Routes) -> String {
        switch endpoint {
        case .everything:
            return baseURL + Constants.everythingPath
        case .top:
            return baseURL + Constants.topPath
        case .sources:
            return baseURL + Constants.sourcesPath
        }
    }
    
}

