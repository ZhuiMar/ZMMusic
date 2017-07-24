//
//  SearchAllCell.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/7/4.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit
import SnapKit

class SearchAllCell: UITableViewCell {

    var article: NSMutableAttributedString? {

        didSet{
            titlelabel.attributedText = article
        }
    }
    
    fileprivate lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = hexColor("ebebf1")
        return lineView
    }()
    
    fileprivate lazy var titlelabel: UILabel = {
        let titlelabel = UILabel()
        titlelabel.textColor = hexColor("333333")
        titlelabel.font = UIFont(name: "PingFangSC-Regular", size: 13)
        return titlelabel
    }()
    
    fileprivate lazy var arrowImage: UIImageView = {
        let arrowImage = UIImageView()
        arrowImage.image = UIImage(named: "music_more")
        return arrowImage
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SearchAllCell {

    fileprivate func setupUI() {
     
        contentView.addSubview(titlelabel)
        titlelabel.snp.makeConstraints { (titlelabel) in
            
            titlelabel.left.equalTo(15)
            titlelabel.centerY.equalTo(contentView.snp.centerY)
            titlelabel.height.equalTo(15)
        }
        
        contentView.addSubview(arrowImage)
        arrowImage.snp.makeConstraints { (arrowImage) in
            
            arrowImage.right.equalTo(-15)
            arrowImage.centerY.equalTo(titlelabel.snp.centerY)
            arrowImage.height.equalTo(15)
            arrowImage.width.equalTo(15)
        }
    
        contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (lineView) in
            
            lineView.left.equalTo(0)
            lineView.height.equalTo(0.5)
            lineView.right.equalTo(0)
            lineView.bottom.equalTo(0)
        }
    }
}
