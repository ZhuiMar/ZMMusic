//
//  WLTSearchView.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/7/4.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit
import SnapKit

class WLTSearchView: UIView {
    
    lazy var searchImage: UIImageView = {
    
        let searchImage = UIImageView()
        searchImage.image = UIImage(named:"huodong_fabu_chaxun")
        return searchImage
    }()
    
    lazy var seachLabel: UILabel = {
    
        let seachLabel = UILabel()
        seachLabel.text = "搜索"
        seachLabel.textColor = rgb(126, g: 126, b: 132, a: 1.0)
        seachLabel.font = UIFont.systemFont(ofSize: 13)
        return seachLabel
    }()
    
    lazy var searchBar: UITextField = {
    
        let searchBar = UITextField()
        searchBar.backgroundColor = UIColor.white
        return searchBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension WLTSearchView {
    
    fileprivate func setupUI() {
    
        addSubview(searchImage)
        searchImage.snp.makeConstraints { (searchImage) in
            
            searchImage.width.equalTo(13)
            searchImage.height.equalTo(13)
            searchImage.centerX.equalTo(self.snp.centerX).offset(-13)
            searchImage.top.equalTo(8.5)
        }
        
        addSubview(seachLabel)
        seachLabel.snp.makeConstraints { (seachLabel) in
            seachLabel.centerX.equalTo(self.snp.centerX).offset(10)
            seachLabel.centerY.equalTo(searchImage.snp.centerY)
        }
        
        
        
        
    }
}
