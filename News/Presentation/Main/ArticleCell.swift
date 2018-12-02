//
//  ArticleCell.swift
//  News
//
//  Created by Ivan Depolo on 30/11/2018.
//  Copyright © 2018 Ivan Depolo. All rights reserved.
//

import Foundation
import UIKit

class ArticleCell: UITableViewCell {
    
    private struct Constants{
        static let cellIdentifier = "ArticleCell"
        static let arrowImageName = "right_arrow"
        
        static let titleSize : CGFloat = 15
        static let dateSize : CGFloat = 11
        
        static let thumbnailWidth = 100
        static let thumbnailHeight = 70
        
        static let margin = 10
        static let arrowWidth = 10
    }
    
    let thumbnail: UIImageView
    let titleLabel: UILabel
    let dateLabel: UILabel
    let forwardArrow: UIImageView

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        thumbnail = UIImageView()
        thumbnail.contentMode = .scaleAspectFit

        titleLabel = UILabel()
        titleLabel.font = Theme.Fonts.title(size: Constants.titleSize)
        titleLabel.textColor = Theme.Color.brighterText
        titleLabel.numberOfLines = 3
        
        dateLabel = UILabel()
        dateLabel.textColor = Theme.Color.lessBrightText
        dateLabel.font = Theme.Fonts.title(size: Constants.dateSize)

        let arrowImage = UIImage(named: Constants.arrowImageName)
        forwardArrow = UIImageView(image: arrowImage)
        forwardArrow.alpha = 0.5

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.backgroundColor = UIColor.clear

        let infoContainer = UIStackView()
        infoContainer.axis = .vertical
        infoContainer.addSubview(titleLabel)
        infoContainer.addSubview(dateLabel)
        
        contentView.addSubview(thumbnail)
        contentView.addSubview(infoContainer)
        contentView.addSubview(forwardArrow)
        
        thumbnail.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(Constants.margin)
            make.centerY.equalToSuperview()
            make.width.equalTo(Constants.thumbnailWidth)
            make.height.equalTo(Constants.thumbnailHeight)
        }

        infoContainer.snp.makeConstraints { (make) in
            make.leading.equalTo(thumbnail.snp.trailing).offset(Constants.margin)
            make.trailing.equalTo(forwardArrow.snp.leading)
        }

        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(Constants.margin)
        }

        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.margin/2)
            make.bottom.equalToSuperview().inset(Constants.margin)
        }

        forwardArrow.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalTo(Constants.arrowWidth)
            make.height.equalToSuperview().dividedBy(3)
            make.trailing.equalToSuperview().inset(Constants.margin/2)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
