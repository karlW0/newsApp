//
//  NewsManager.swift
//  News
//
//  Created by Ivan Depolo on 02/12/2018.
//  Copyright © 2018 Ivan Depolo. All rights reserved.
//

import Foundation
import AlamofireImage

class NewsManager{
    
    private struct Constants {
        static let categoryKey = "category"
        static let categotyVal = "technology"
        static let countryKey = "country"
        static let countryVal = "us"
        
        static let pageKey = "page"
        static let articlesKey = "articles"
        
        static let connectornotSet = "APIConnector not set"
    }
    
    // shared variable making  the manager a singleton
    public static let shared = NewsManager()

    private init(){}
    
    fileprivate var apiConnector: APIConnectable?

    func configure(with apiConnector: APIConnectable) {
        guard self.apiConnector == nil else { return }
        self.apiConnector = apiConnector
    }

    func getTopTechHeadlines( forPage page : Int, completion: @escaping ( [Article] ) -> ()) {
        guard let apiConnector = apiConnector else {
            fatalError( Constants.connectornotSet )
        }
        
        var parameters : [String : Any] = [Constants.categoryKey : Constants.categotyVal,
                                           Constants.countryKey : Constants.countryVal]
        parameters.updateValue( Constants.pageKey, forKey: String(page))
        
        apiConnector.getTopHeadlines(with: parameters) { (result) in
            switch result {
            case .success(let json):
                if let articlesJson = json[Constants.articlesKey] as? [[AnyHashable : Any]] {
                    let articles = articlesJson.compactMap( Article.init )
                    completion(articles)
                }else{
                    completion([])
                }
            case .error(_):
                ()  // no error handling
                // needs to be refactored
            }
        }

    }
    
}
