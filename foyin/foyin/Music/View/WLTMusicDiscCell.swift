//
//  WLTMusicDiscCell.swift
//  foyin
//
//  Created by  luzhaoyang on 17/6/20.
//  Copyright © 2017年 Kingstong. All rights reserved.
//

import UIKit
import Kingfisher

class WLTMusicDiscCell: UICollectionViewCell {
    

    var itemsModel: SoundModel? {
        didSet{
             cover.kf.setImage(with: URL(string: itemsModel!.fileCover))
        }
    }
    
    fileprivate lazy var disc: UIImageView = {
        let disc = UIImageView()
        disc.image = UIImage(named: "cipang")
        return disc
    }()
    
    lazy var cover: UIImageView = {
        let cover = UIImageView()
        cover.layer.cornerRadius = 95.5
        cover.layer.masksToBounds = true
        cover.image = UIImage(named: "remedial")
        return cover
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension WLTMusicDiscCell {

    fileprivate func setupUI() {
    
        // 添加光碟
        addSubview(disc)
        disc.snp.makeConstraints { (disc) in
            
            disc.centerX.equalTo(self.contentView.snp.centerX)
            disc.centerY.equalTo(self.contentView.snp.centerY)
            disc.width.equalTo(285)
            disc.height.equalTo(285)
        }
        
        // 加载封面的图片
        addSubview(cover)
        cover.snp.makeConstraints { (cover) in
            
            cover.center.equalTo(disc.snp.center)
            cover.width.equalTo(191)
            cover.height.equalTo(191)
        }
        
    }
}









