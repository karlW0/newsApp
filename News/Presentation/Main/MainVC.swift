//
//  File.swift
//  News
//
//  Created by Ivan Depolo on 30/11/2018.
//  Copyright © 2018 Ivan Depolo. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class MainVC: UIViewController {

    private struct Constants{
        static let cellIdentifier = "ArticleCell"
        static let vcName = "Tech News"
    }
    
    fileprivate var mainView: MainView { return view as! MainView }
    fileprivate let viewModel: MainVM

    init(viewModel : MainVM){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
      view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        self.title = Constants.vcName
        
        mainView.tableView.register(ArticleCell.self, forCellReuseIdentifier: Constants.cellIdentifier )
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.rowHeight = CGFloat(100)

        viewModel.delegate = self
        viewModel.fetchArticles()
    }

}

extension MainVC : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! ArticleCell
        let item = viewModel.articles[indexPath.row]
        
        cell.titleLabel.text = item.title
        
        if let image = item.urlToImage {
            if let url = URL(string: image){
                cell.thumbnail.af_setImage(withURL: url)
            }
            // image loading is faulty, to siome empty inageviews that should stay so an image is loaded "randomly"
            // needs to be refactored  
        }
        
        cell.dateLabel.text = item.publishedAt
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = DetailVC( article: viewModel.articles[indexPath.row] )   //UIViewController()
        vc.view.backgroundColor = UIColor.black;

        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension MainVC : MainDataDelegate{
    func reloadTable() {
        mainView.tableView.reloadData()
    }
}
