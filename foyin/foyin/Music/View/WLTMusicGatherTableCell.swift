//
//  WLTMusicGatherTableCell.swift
//  foyin
//
//  Created by  luzhaoyang on 17/6/16.
//  Copyright © 2017年 Kingstong. All rights reserved.
//

import UIKit

protocol DetailCellDelegate {
    func clickDownload(currentModel: SoundModel)
}

class WLTMusicGatherTableCell: UITableViewCell {
    
    var delegate: DetailCellDelegate?
    
    var model: SoundModel! {
        didSet{
            musicCoverImage.kf.setImage(with: URL(string: model.fileCover))
            musicUpdateTimer.text = "\(model.updateTime)"
            musicHearNum.text = String.addUnit(model.scanNum)
            musicTittle.text = "\(model.fileTitle)"
        }
    }

    fileprivate lazy var imageViewBack: UIView = {
        let imageViewBack = UIView()
        imageViewBack.layer.cornerRadius = 20
        imageViewBack.layer.masksToBounds = true
        imageViewBack.layer.borderWidth = 1
        imageViewBack.layer.borderColor = UIColor.white.cgColor
        return imageViewBack
    }()

    fileprivate lazy var musicCoverImage: UIImageView = {
        
        let musicCoverImage = UIImageView()
        musicCoverImage.backgroundColor = UIColor.yellow
        musicCoverImage.layer.cornerRadius = 17.5
        musicCoverImage.layer.masksToBounds = true
        return musicCoverImage
    }()
    
    fileprivate lazy var musicTittle: UILabel = {
        let musicTittle = UILabel()
        musicTittle.textColor = hexColor("333333")
        musicTittle.font = UIFont(name: "PingFangSC-Medium", size: 15)
        return musicTittle
    }()

    fileprivate lazy var musicHearIcon: UIImageView = {
        let musicHearIcon = UIImageView()
        musicHearIcon.image = UIImage(named: "erji")
        return musicHearIcon
    }()
    
    fileprivate lazy var musicHearNum: UILabel = {
        let musicHearNum = UILabel()
        musicHearNum.textColor = hexColor("888888")
        musicHearNum.font = UIFont(name: "PingFangSC-Regular", size: 11)
        return musicHearNum
    }()
    
    fileprivate lazy var musicUpdateIcon: UIImageView = {
        let musicUpdateIcon = UIImageView()
        musicUpdateIcon.image = UIImage(named: "naozhong")
        return musicUpdateIcon
    }()
    
    fileprivate lazy var musicUpdateTimer: UILabel = {
        let musicHearNum = UILabel()
        musicHearNum.textColor = hexColor("888888")
        musicHearNum.font = UIFont(name: "PingFangSC-Regular", size: 11)
        return musicHearNum
    }()
    
    fileprivate lazy var moreBtn: UIButton = {
        
        let moreBtn = UIButton(type: .custom)
        let image = UIImage(named: "gengduo_new")
        moreBtn.setBackgroundImage(image, for: .normal)
        moreBtn.addTarget(self, action: #selector(WLTMusicGatherTableCell.clickMoreBtnAction), for: .touchUpInside)
        return moreBtn
    }()
    
    fileprivate lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = rgb(235, g: 235, b: 214, a: 1.0)
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


extension WLTMusicGatherTableCell {

    fileprivate func setupUI() {
        
        // 0.添加封面的背景
        addSubview(imageViewBack)
        imageViewBack.snp.makeConstraints { (imageViewBack) in
            
            imageViewBack.top.equalTo(10)
            imageViewBack.left.equalTo(18)
            imageViewBack.height.equalTo(40)
            imageViewBack.width.equalTo(40)
        }
        
        // 1.添加音乐封面
        addSubview(musicCoverImage)
        musicCoverImage.snp.makeConstraints { (musicCoverImage) in
            musicCoverImage.edges.equalTo(imageViewBack).inset(UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5))
        }
        
        // 2.音乐标题
        addSubview(musicTittle)
        musicTittle.snp.makeConstraints { (musicTittle) in
            musicTittle.top.equalTo(13)
            musicTittle.left.equalTo(imageViewBack.snp.right).offset(10)
            musicTittle.right.equalTo(-55)
        }
        
        // 3.下载次数的icon
        addSubview(musicHearIcon)
        musicHearIcon.snp.makeConstraints { (musicHearIcon) in
            musicHearIcon.top.equalTo(musicTittle.snp.bottom).offset(14)
            musicHearIcon.left.equalTo(imageViewBack.snp.right).offset(10)
            musicHearIcon.width.equalTo(13)
            musicHearIcon.height.equalTo(13)
        }
        
        // 3.1下载次数
        addSubview(musicHearNum)
        musicHearNum.snp.makeConstraints { (musicHearNum) in
            musicHearNum.left.equalTo(musicHearIcon.snp.right).offset(5)
            musicHearNum.top.equalTo(musicHearIcon.snp.top)
            musicHearNum.bottom.equalTo(musicHearIcon.snp.bottom)
        }
        
//        // 4.更新时间icon
//        addSubview(musicUpdateIcon)
//        musicUpdateIcon.snp.makeConstraints { (musicUpdateIcon) in
//            musicUpdateIcon.left.equalTo(musicHearNum.snp.right).offset(25)
//            musicUpdateIcon.top.equalTo(musicHearNum.snp.top)
//            musicUpdateIcon.bottom.equalTo(musicHearNum.snp.bottom)
//            musicUpdateIcon.width.equalTo(13)
//        }
//        
//        // 4.1更新时间
//        addSubview(musicUpdateTimer)
//        musicUpdateTimer.snp.makeConstraints { (musicUpdateTimer) in
//            musicUpdateTimer.left.equalTo(musicUpdateIcon.snp.right).offset(5)
//            musicUpdateTimer.top.equalTo(musicUpdateIcon.snp.top)
//            musicUpdateTimer.bottom.equalTo(musicUpdateIcon.snp.bottom)
//        }
        
        // 5.添加更多的按钮
        addSubview(moreBtn)
        moreBtn.snp.makeConstraints { (moreBtn) in
            
            moreBtn.centerY.equalTo(musicTittle.snp.centerY)
            moreBtn.right.equalTo(-15)
            moreBtn.width.equalTo(29)
            moreBtn.height.equalTo(29)
        }
        
        // 6.添加底部分割线
        addSubview(lineView)
        lineView.snp.makeConstraints { (lineView) in
            
            lineView.left.equalTo(musicTittle.snp.left)
            lineView.bottom.equalTo(self.contentView.snp.bottom)
            lineView.height.equalTo(0.5)
            lineView.right.equalTo(0)
        }
    
    }
}


extension WLTMusicGatherTableCell {

    func clickMoreBtnAction() {
        
//        MusicToolBar.sharedMusicToolBar.musicNameLabel.text = musicModel.musicName
        delegate?.clickDownload(currentModel: model)
//        NotificationCenter.default.addObserver(self, selector: #selector(BuddhaMusicDownLoadCell.cellDownLoadMusice(_:)), name: Notification.Name(rawValue: "cellDownLoadMusice"), object: nil)
    }
}




