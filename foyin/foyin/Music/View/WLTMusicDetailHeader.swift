//
//  WLTMusicDetailHeader.swift
//  foyin
//
//  Created by  luzhaoyang on 17/6/16.
//  Copyright © 2017年 Kingstong. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class WLTMusicDetailHeader: UIView {
    
    var model: SoundModel? {
        
        didSet {
            
            imageView.kf.setImage(with:URL(string: (model?.fileCover)!))
            playCount.text = "播放: " + String.addUnit((model?.scanNum)!)
            musicTitle.text = "\((model?.fileTitle)!)"
            
            let date = "\((model?.updateTime)!)"
            let update = date.stringWithTimeStamp(with: "yyyy-MM-dd")
            musicUpdate.text = "更新: " + "\(update)"
            
            var classStr: String?
            let type = model?.fileType
            
            switch type {
            case 0?:
                classStr = "佛教音乐"
                break
            case 3?:
                classStr = "听闻佛事"
                break
            case 5?:
                classStr = "智慧开示"
                break
            default:
                break
            }
            
            let attribute = NSMutableAttributedString(string: "分类: " + "\((classStr)!)")
            let range = NSMakeRange(0, 3)
            let color = hexColor("888888")
            attribute.addAttribute(NSForegroundColorAttributeName, value:color, range:range)
            musicClass.attributedText = attribute
        }
    }
    
    fileprivate lazy var imageViewBack: UIView = {
        let imageViewBack = UIView()
        imageViewBack.backgroundColor = UIColor.white
        imageViewBack.layer.shadowOpacity = 0.5
        imageViewBack.layer.shadowColor = UIColor.black.cgColor
        imageViewBack.layer.shadowOffset = CGSize(width: 1, height: 1)
        return imageViewBack
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    fileprivate lazy var musicTitle: UILabel = {
        let musicTitle = UILabel()
        musicTitle.font = UIFont(name: "PingFangSC-Medium", size: 15)
        musicTitle.textColor = hexColor("444444")
        return musicTitle
    }()
    
    fileprivate lazy var playCount: UILabel = {
        let playCount = UILabel()
        playCount.textColor = hexColor("888888")
        playCount.font = UIFont(name: "PingFangSC-Regular", size: 11)
        return playCount
    }()
    
    fileprivate lazy var musicClass: UILabel = {
        let musicClass = UILabel()
        musicClass.textColor = hexColor("baa674")
        musicClass.font = UIFont(name: "PingFangSC-Regular", size: 11)
        return musicClass
    }()
    
    fileprivate lazy var musicUpdate: UILabel = {
        let musicUpdate = UILabel()
        musicUpdate.textColor = hexColor("888888")
        musicUpdate.font = UIFont(name: "PingFangSC-Regular", size: 11)
        return musicUpdate
    }()
    
    class func clone() ->WLTMusicDetailHeader {
        let view = WLTMusicDetailHeader(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 158))
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension WLTMusicDetailHeader {

    fileprivate func setupUI() {
    
        // 1.添加音乐图片背景的View
        addSubview(imageViewBack)
        imageViewBack.snp.makeConstraints { (imageViewBack) in
            imageViewBack.top.equalTo(18)
            imageViewBack.left.equalTo(15)
            imageViewBack.width.equalTo(110)
            imageViewBack.height.equalTo(110)
        }
        
        // 1.1 添加微信的图片
        imageViewBack.addSubview(imageView)
        imageView.snp.makeConstraints { (imageView) in
             imageView.edges.equalTo(imageViewBack).inset(UIEdgeInsetsMake(7, 7, 7, 7))
        }
        
        // 2.添加音乐标题
        addSubview(musicTitle)
        musicTitle.snp.makeConstraints { (musicTitle) in
            musicTitle.top.equalTo(imageViewBack.snp.top).offset(15)
            musicTitle.left.equalTo(imageViewBack.snp.right).offset(25)
            musicTitle.right.equalTo(-25)
            musicTitle.height.equalTo(15)
        }
        
        // 3.添加音乐的播放次数
        addSubview(playCount)
        playCount.snp.makeConstraints { (playCount) in
            playCount.top.equalTo(musicTitle.snp.bottom).offset(17)
            playCount.left.equalTo(imageViewBack.snp.right).offset(25)
            playCount.height.equalTo(11)
        }
        
        // 4.添加音乐的类别
        addSubview(musicClass)
        musicClass.snp.makeConstraints { (musicClass) in
            musicClass.top.equalTo(playCount.snp.bottom).offset(10)
            musicClass.left.equalTo(imageViewBack.snp.right).offset(25)
            musicClass.height.equalTo(11)
        }
        
        // 5.添加音乐的播放时间
        addSubview(musicUpdate)
        musicUpdate.snp.makeConstraints { (musicUpdate) in
            musicUpdate.top.equalTo(musicClass.snp.bottom).offset(10)
            musicUpdate.left.equalTo(imageViewBack.snp.right).offset(25)
            musicUpdate.height.equalTo(11)
        }
    
    }
}




