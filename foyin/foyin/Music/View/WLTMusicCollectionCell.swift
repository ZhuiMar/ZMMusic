//
//  WLTMusicCollectionCell.swift
//  foyin
//
//  Created by  luzhaoyang on 17/6/16.
//  Copyright © 2017年 Kingstong. All rights reserved.
//

import UIKit

class WLTMusicCollectionCell: UICollectionViewCell {
    
    
    fileprivate lazy var musicCoverImage: UIImageView = {
        
        let musicCoverImage = UIImageView()
        musicCoverImage.image = UIImage(named: "morenjiazai")
        return musicCoverImage
    }()
    
    fileprivate lazy var shadowImage: UIImageView = {
    
        let shadowImage = UIImageView()
        shadowImage.backgroundColor = UIColor.clear
        shadowImage.image = UIImage(named: "mengban")
        return shadowImage
    }()
    
    fileprivate lazy var headsetImage: UIImageView = {
        
        let headsetImage = UIImageView()
        headsetImage.image = UIImage(named: "erji")
        return headsetImage
    }()

    fileprivate lazy var downLoadNnm: UILabel = {
        
        let downLoadNnm = UILabel()
        downLoadNnm.backgroundColor = UIColor.clear
        downLoadNnm.textColor = UIColor.white
        downLoadNnm.font = UIFont(name: "PingFangSC-Regular", size: 12)
        return downLoadNnm
    }()
    
    fileprivate lazy var musicTittle: UILabel = {
        
        let musicTittle = UILabel()
        musicTittle.numberOfLines = 0
        musicTittle.textColor = hexColor("555555")
        musicTittle.font = UIFont(name: "PingFangSC-Medium", size: 12)
        return musicTittle
    }()
    
    var model: SoundModel!{
        didSet{

            musicCoverImage.kf.setImage(with: URL(string: model.fileCover))
            downLoadNnm.text = String.addUnit(model.scanNum)
            musicTittle.text = "\(model.fileTitle)"
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




extension WLTMusicCollectionCell {

    fileprivate func setupUI() {
        
        // 1.添加封面
        addSubview(musicCoverImage)
        musicCoverImage.snp.makeConstraints { [weak self] (musicCoverImage) in
            
            musicCoverImage.top.equalTo(0)
            musicCoverImage.left.equalTo(0)
            musicCoverImage.right.equalTo(0)
            musicCoverImage.height.equalTo((self?.frame.width)!)
        }
        
        // 2.添加底部的阴影
        musicCoverImage.addSubview(shadowImage)
        shadowImage.snp.makeConstraints { (shadowImage) in
            
            shadowImage.left.equalTo(0)
            shadowImage.bottom.equalTo(0)
            shadowImage.right.equalTo(0)
            shadowImage.height.equalTo(45)
        }
        
        // 2.1添加耳机的图标
        shadowImage.addSubview(headsetImage)
        headsetImage.snp.makeConstraints { (headsetImage) in
            
            headsetImage.left.equalTo(4)
            headsetImage.bottom.equalTo(-6)
            headsetImage.width.equalTo(13)
            headsetImage.height.equalTo(13)
        }
        
        // 3.添加下载次数
        shadowImage.addSubview(downLoadNnm)
        downLoadNnm.snp.makeConstraints { (downLoadNnm) in
            
            downLoadNnm.left.equalTo(headsetImage.snp.right).offset(4)
            downLoadNnm.bottom.equalTo(headsetImage.snp.bottom)
            downLoadNnm.top.equalTo(headsetImage.snp.top)
        }
        
        // 4.添加音乐标题
        addSubview(musicTittle)
        musicTittle.snp.makeConstraints { (musicTittle) in
            
            musicTittle.top.equalTo(musicCoverImage.snp.bottom).offset(4)
            musicTittle.left.equalTo(0)
            musicTittle.right.equalTo(0)
        }
        
    }
}
