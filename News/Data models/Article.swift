//
//  Article.swift
//  News
//
//  Created by Ivan Depolo on 29/11/2018.
//  Copyright © 2018 Ivan Depolo. All rights reserved.
//

import Foundation

struct SourceArticle {
    let id : String
    let name : String
}

struct Article {
    let source : SourceArticle
    let author : String
    let title : String
    let description : String
    let url : String
    let urlToImage : String
    let publishedAt : String
    let content : String
}
