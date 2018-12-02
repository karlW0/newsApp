//
//  DetailView.swift
//  News
//
//  Created by Ivan Depolo on 02/12/2018.
//  Copyright © 2018 Ivan Depolo. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class DetailView : UIView {
        
    fileprivate struct Constants {
        static let leftRightMargin: CGFloat = 20
        static let topMargin: CGFloat = 20
    }

    let image : UIImageView
    let title : UILabel
    let author : UILabel
    let content : UILabel

    init() {
        
        image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        title = UILabel()
        title.font = Theme.Fonts.title(size: 23)
        title.textColor = Theme.Color.brighterText
        title.numberOfLines = 0
        
        author = UILabel()
        author.font = Theme.Fonts.title(size: 18)
        author.textColor = Theme.Color.lessBrightText
        author.numberOfLines = 0
        
        content = UILabel()
        content.font = Theme.Fonts.content(size: 16)
        content.textColor = Theme.Color.brighterText
        content.numberOfLines = 0
        
        super.init(frame: CGRect.zero)

        addSubview(image)
        addSubview(title)
        addSubview(author)
        addSubview(content)
        
        image.snp.makeConstraints { (make) in
            make.trailing.top.leading.equalToSuperview()
        }
        
        title.snp.makeConstraints { (make) in
            make.top.equalTo(image.snp.bottom)
            make.trailing.leading.equalToSuperview().inset(Constants.leftRightMargin)
        }
        
        author.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).inset(-5)
            make.trailing.leading.equalToSuperview().inset(Constants.leftRightMargin)
        }
        
        content.snp.makeConstraints { (make) in
            make.top.equalTo(author.snp.bottom).inset(-10)
            make.trailing.leading.equalToSuperview().inset(Constants.leftRightMargin)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
