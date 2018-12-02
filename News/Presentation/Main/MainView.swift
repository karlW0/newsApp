//
//  MainView.swift
//  News
//
//  Created by Ivan Depolo on 30/11/2018.
//  Copyright © 2018 Ivan Depolo. All rights reserved.
//

import Foundation
import SnapKit

class MainView: UIView {

    let tableView: UITableView
    
    init() {
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.clear
        
        super.init(frame: CGRect.zero)
        
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

