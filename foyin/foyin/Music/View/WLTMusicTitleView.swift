//
//  WLTMusicTitleView.swift
//  佛音
//
//  Created by  luzhaoyang on 17/6/15.
//  Copyright © 2017年 Kingstong. All rights reserved.
//

import UIKit
import SnapKit

protocol WLTMusicTitleViewDelegate {
    func musicTitleView(_ musicTitleView: WLTMusicTitleView, title: String)
}

enum musicType: String {
    case buddhist = "推荐"
    case headerBuddhist = "听闻佛事"
    case wisdomReveal = "智慧开示"
}

class WLTMusicTitleView: UIView {

    var delegate:WLTMusicTitleViewDelegate?
    fileprivate var title: String?
    fileprivate var actionTitle: String?
    
    lazy var titleLabel: UILabel = {
    
        let titleLabel = UILabel()
        titleLabel.text = self.title
        titleLabel.textColor = hexColor("333333")
        titleLabel.font = UIFont(name: "PingFangSC-Semibold", size: 14)
        return titleLabel
    }()
    
    fileprivate lazy var arrow: UIImageView = {
        let arrow = UIImageView()
        if self.actionTitle == "更多" {
            arrow.image = UIImage(named: "music_more")
        }else {
            arrow.image = UIImage(named: "")
        }
        return arrow
    }()
    
    fileprivate lazy var moreLabel: UILabel = {
        let moreLabel = UILabel()
        moreLabel.text = self.actionTitle
        moreLabel.textAlignment = .center
        moreLabel.textColor = hexColor("999999")
        moreLabel.font = UIFont(name: "PingFangSC-Medium", size: 14)
        return moreLabel
    }()
    
    fileprivate lazy var clickButton: UIButton = {
        let clickButton = UIButton(type: .custom)
        clickButton.backgroundColor = UIColor.clear
        clickButton.addTarget(self, action: #selector(WLTMusicTitleView.clickMoreBtnAction), for: .touchUpInside)
        return clickButton
    }()

    init(frame: CGRect, title: String, actionTitle: String) {
        self.title = title
        self.actionTitle = actionTitle
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WLTMusicTitleView {

    fileprivate func setupUI() {
        
        // 1.添加title
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (titleLabel) in
            titleLabel.left.equalTo(15)
            titleLabel.top.equalTo((self.frame.size.height-15)/2)
            titleLabel.height.equalTo(15)
        }
        
        // 2.添加箭头标签
        addSubview(arrow)
        arrow.snp.makeConstraints { (arrow) in
            arrow.right.equalTo(-15)
            arrow.centerY.equalTo(titleLabel.snp.centerY)
            arrow.width.equalTo(15.5)
            arrow.height.equalTo(15.5)
        }
        
        // 3.添加"更多/排序"
        addSubview(moreLabel)
        moreLabel.snp.makeConstraints { (moreLabel) in
            moreLabel.right.equalTo(arrow.snp.left).offset(-10)
            moreLabel.centerY.equalTo(titleLabel.snp.centerY)
            moreLabel.height.equalTo(15)
        }
        
        // 4.添加点击的按钮
        addSubview(clickButton)
        clickButton.snp.makeConstraints { (clickButton) in
            clickButton.top.equalTo(moreLabel.snp.top)
            clickButton.left.equalTo(moreLabel.snp.left)
            clickButton.right.equalTo(arrow.snp.right)
            clickButton.bottom.equalTo(moreLabel.snp.bottom)
        }
        
    }
}


extension WLTMusicTitleView {
    
    func clickMoreBtnAction() {
        delegate?.musicTitleView(self, title: self.title!)
    }
}













