//
//  DetailVC.swift
//  News
//
//  Created by Ivan Depolo on 02/12/2018.
//  Copyright © 2018 Ivan Depolo. All rights reserved.
//

import Foundation
import UIKit

class DetailVC: UIViewController {
    
    fileprivate struct Constants{
        static let authorPrefix = "by  "
        static let linkIconImageName = "link"
    }
    
    fileprivate var mainView: DetailView { return view as! DetailView }
    fileprivate let article : Article
 
    init( article : Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = DetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.edgesForExtendedLayout = []
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: Constants.linkIconImageName),
                                                                   style: .done,
                                                                   target: self,
                                                                   action: #selector(openLink) )
        
        if
            let stringUrl = article.urlToImage,
            let url = URL(string: stringUrl ) {
            mainView.image.af_setImage(withURL: url )
            mainView.image.contentMode = .scaleAspectFit
        }
        
        mainView.title.text = article.title
        
        if let author = article.author {
            mainView.author.text = Constants.authorPrefix + author
        }
        
        if let content = article.content {
            mainView.content.text = content
            // a larger content string would fall of the screen with no possibility of scroling
            // the entire view needs to be refactored to a scrollview + children layout
        }
        
    }
    
    @objc func openLink(){
        guard let url = URL(string: article.url) else { return }
        UIApplication.shared.open(url)
    }
    
}
