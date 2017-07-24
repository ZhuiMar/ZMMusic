//
//  SearchSourcesCell.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/7/4.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit
import Kingfisher

class SearchSourcesCell: UITableViewCell {

    var musicModel: SearchMusicModel? {
    
        didSet{
            
            guard let urlStr = musicModel?.fileCover else {
                return
            }
            
            sourcesImage.kf.setImage(with: URL(string: (urlStr)))
            titleLabel.text = musicModel?.fileTitle
        }
    }
    
    var bookModel: BookItemModel? {
    
        didSet{
            
            guard let urlStr = bookModel?.fileCover else {
                return
            }
            sourcesImage.kf.setImage(with: URL(string: (urlStr)))
            titleLabel.text = bookModel?.fileTitle
        }
    }
    
    var storyModel: searchStoryModel? {
    
        didSet{
            
            guard let urlStr = storyModel?.fileCover else {
                return
            }
            sourcesImage.kf.setImage(with: URL(string: (urlStr)))
            titleLabel.text = storyModel?.fileTitle
        }
    }
    
    fileprivate lazy var lineView: UIView = {
        
        let lineView = UIView()
        lineView.backgroundColor = hexColor("ebebf1")
        return lineView
    }()
    
    lazy var sourcesImage: UIImageView = {
        let sourcesImage = UIImageView()
        sourcesImage.layer.shadowOpacity = 0.5
        sourcesImage.layer.shadowColor = UIColor.black.cgColor
        sourcesImage.layer.shadowOffset = CGSize(width: 1, height: 1)
        return sourcesImage
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
    
        let titleLabel = UILabel()
        titleLabel.textColor = hexColor("333333")
        titleLabel.font = UIFont(name: "PingFangSC-Regular", size: 13)
        return titleLabel
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


extension SearchSourcesCell {
    
    func setupUI() {
        
        contentView.addSubview(sourcesImage)
        sourcesImage.snp.makeConstraints { (sourcesImage) in
         
            sourcesImage.centerY.equalTo(self.contentView.snp.centerY)
            sourcesImage.left.equalTo(9)
            sourcesImage.width.equalTo(28)
            sourcesImage.height.equalTo(28)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (titleLabel) in
            
            titleLabel.centerY.equalTo(sourcesImage.snp.centerY)
            titleLabel.left.equalTo(sourcesImage.snp.right).offset(10)
            titleLabel.height.equalTo(14)
            titleLabel.right.equalTo(-15)
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
