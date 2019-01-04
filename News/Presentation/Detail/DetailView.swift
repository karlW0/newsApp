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
    
    let scrollView : UIScrollView

    init() {
        
        image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
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
        
        scrollView = UIScrollView()

        super.init(frame: CGRect.zero)
        
        let imageContainer = UIView()
        imageContainer.addSubview(image)
        scrollView.addSubview(imageContainer)
        scrollView.addSubview(title)
        scrollView.addSubview(author)
        scrollView.addSubview(content)
        
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        imageContainer.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView)
            make.right.left.equalTo(self)
            make.height.equalTo(imageContainer.snp.width).multipliedBy(0.7)
        }
        
        image.snp.makeConstraints { (make) in
            make.left.right.equalTo(imageContainer)
            make.top.equalTo(self).priority(.high)
            make.height.greaterThanOrEqualTo(imageContainer.snp.height).priority(.required)
            make.bottom.equalTo(imageContainer.snp.bottom)
        }
        
        title.snp.makeConstraints { (make) in
            make.top.equalTo(image.snp.bottom)
            make.right.left.equalTo(self).inset(Constants.leftRightMargin)
        }
        
        author.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).inset(-5)
            make.right.left.equalTo(self).inset(Constants.leftRightMargin)
        }
        
        content.snp.makeConstraints { (make) in
            make.top.equalTo(author.snp.bottom).inset(-10)
            make.right.left.equalTo(self).inset(Constants.leftRightMargin)
            make.bottom.equalTo(scrollView)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
