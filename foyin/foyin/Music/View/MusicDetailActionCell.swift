//
//  MusicDetailActionCell.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/7/11.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit
import SnapKit

class MusicDetailActionCell: UITableViewCell {

    var icon: String? {
        didSet{
            actionIcon.image = UIImage(named:icon!)
        }
    }
    
    var title: String? {
        didSet{
            actiontitle.text = title
        }
    }
    
    fileprivate lazy var actionIcon: UIImageView = {
        let actionIcon = UIImageView()
        return actionIcon
    }()
    fileprivate lazy var actiontitle: UILabel = {
        let actiontitle = UILabel()
        actiontitle.textColor = hexColor("333333")
        actiontitle.font = UIFont(name: "PingFangSC-Regular", size: 13)
        return actiontitle
    }()
    fileprivate lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = rgb(235, g: 235, b: 241, a: 1.0)
        return lineView
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


extension MusicDetailActionCell {

    fileprivate func setupUI() {
    
        addSubview(actionIcon)
        actionIcon.snp.makeConstraints { (actionIcon) in
            actionIcon.centerY.equalTo(self.snp.centerY)
            actionIcon.height.equalTo(25)
            actionIcon.width.equalTo(25)
            actionIcon.left.equalTo(15)
        }
        
        addSubview(actiontitle)
        actiontitle.snp.makeConstraints { (actiontitle) in
            
            actiontitle.centerY.equalTo(actionIcon.snp.centerY)
            actiontitle.left.equalTo(actionIcon.snp.right).offset(15)
            actiontitle.height.equalTo(15)
        }
        
        addSubview(lineView)
        lineView.snp.makeConstraints { (lineView) in
            
            lineView.left.equalTo(0)
            lineView.height.equalTo(0.5)
            lineView.right.equalTo(0)
            lineView.bottom.equalTo(0)
        }
    }
}
