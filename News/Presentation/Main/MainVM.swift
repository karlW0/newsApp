//
//  MainVM.swift
//  News
//
//  Created by Ivan Depolo on 02/12/2018.
//  Copyright © 2018 Ivan Depolo. All rights reserved.
//

import Foundation
import SVProgressHUD

protocol MainDataDelegate : class
{
    func reloadTable()
}

class MainVM {
    
    weak var delegate : MainDataDelegate?
    let newsManager : NewsManager
    
    init(newsManager: NewsManager) {
        self.newsManager = newsManager
    }
    
    var articles : [Article] = []
    
    func fetchArticles(){
        DispatchQueue.main.async {
            SVProgressHUD.setDefaultMaskType(.black)
            SVProgressHUD.show(withStatus: nil)
        }
        newsManager.getTopTechHeadlines(forPage: 1) { articles in
            self.articles = articles
            self.delegate?.reloadTable()
            DispatchQueue.main.async {
                SVProgressHUD.dismiss(withDelay: 0.5)
            }
        }
    }
    
}
