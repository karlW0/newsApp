//
//  Article.swift
//  News
//
//  Created by Ivan Depolo on 29/11/2018.
//  Copyright © 2018 Ivan Depolo. All rights reserved.
//

import Foundation

fileprivate struct Constants {
    static let sourceKey = "source"
    static let authorKey = "author"
    static let titleKey = "title"
    static let descriptionKey = "description"
    static let urlKey = "url"
    static let urlToImageKey = "urlToImage"
    static let publishedAtKey = "publishedAt"
    static let contentKey = "content"
    
    static let idKey = "id"
    static let nameKey = "name"
}

struct SourceArticle {
    let id : String?
    let name : String
}

struct Article {
    let source : SourceArticle
    let author : String?
    let title : String
    let description : String?
    let url : String
    let urlToImage : String?
    let publishedAt : String?
    let content : String?
    
    init( source : SourceArticle,
          author : String?,
          title : String,
          description : String?,
          url : String,
          urlToImage : String?,
          publishedAt : String?,
          content : String? )
    {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
    
    init?(dict: [AnyHashable: Any]) {
        guard
            let source = dict[Constants.sourceKey] as? [AnyHashable: Any],
            let title = dict[Constants.titleKey] as? String,
            let url = dict[Constants.urlKey] as? String
            else {
                return nil
        }
        
        let author = dict[Constants.authorKey] as? String
        
        let content = dict[Constants.contentKey] as? String
        let imageUrl = dict[Constants.urlToImageKey] as? String
        var publishedAt = dict[Constants.publishedAtKey] as? String

        
        if let publishedDate = publishedAt {
            publishedAt = reformat(time: publishedDate)
        }
        
        let sourceId = source[Constants.idKey] as? String
        let sourceName = source[Constants.nameKey] as? String
        
        let sourceObject = SourceArticle(id: sourceId,
                                         name: sourceName!)
        self.init(source: sourceObject,
                  author: author,
                  title: title,
                  description: nil,
                  url: url,
                  urlToImage: imageUrl,
                  publishedAt: publishedAt,
                  content: content)
    }
    
}
