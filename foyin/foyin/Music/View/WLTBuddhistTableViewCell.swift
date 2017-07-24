//
//  WLTBuddhistTableViewCell.swift
//  foyin
//
//  Created by  luzhaoyang on 17/6/16.
//  Copyright © 2017年 Kingstong. All rights reserved.
//

import UIKit

protocol WLTBuddhistTableViewCellDelegate {
    
    func clickCell(_ tag: Int)
}

class WLTBuddhistTableViewCell: UITableViewCell {

    var delegate: WLTBuddhistTableViewCellDelegate?
    
    var model: SoundModel!{
        didSet{
            musicCoverImage.kf.setImage(with: URL(string: model.fileCover))
            musicDescribe.text = "\(model.fileDesc)"
            musicHearNum.text = String.addUnit(model.scanNum)
            musicTittle.text = "\(model.fileTitle)"
        }
    }

    fileprivate lazy var musicCoverImage: UIImageView = {
        let musicCoverImage = UIImageView()
        return musicCoverImage
    }()
    
    fileprivate lazy var musicTittle: UILabel = {
        
        let musicTittle = UILabel()
        musicTittle.textColor = hexColor("333333")
        musicTittle.font = UIFont(name: "PingFangSC-Medium", size: 15)
        return musicTittle
    }()

    fileprivate lazy var musicDescribe: UILabel = {
        let musicDescribe = UILabel()
        musicDescribe.textColor = hexColor("777777")
        musicDescribe.font = UIFont(name: "PingFangSC-Regular", size: 13)
        return musicDescribe
    }()
    
    fileprivate lazy var musicGatherIcon: UIImageView = {
        let musicGatherIcon = UIImageView()
        musicGatherIcon.image = UIImage(named: "zhuanji")
        return musicGatherIcon
    }()
    
    fileprivate lazy var musicGather: UILabel = {
        
        let musicGather = UILabel()
        musicGather.textColor = hexColor("777777")
        musicGather.font = UIFont(name: "PingFangSC-Regular", size: 11)
        return musicGather
    }()

    fileprivate lazy var musicHearIcon: UIImageView = {
        
        let musicHearIcon = UIImageView()
        musicHearIcon.image = UIImage(named: "erji")
        return musicHearIcon
    }()

    fileprivate lazy var musicHearNum: UILabel = {
        
        let musicHearNum = UILabel()
        musicHearNum.textColor = hexColor("777777")
        musicHearNum.font = UIFont(name: "PingFangSC-Regular", size: 11)
        return musicHearNum
    }()

    fileprivate lazy var downLoadNnm: UILabel = {
        
        let downLoadNnm = UILabel()
        return downLoadNnm
    }()
    
    fileprivate lazy var lineView: UIView = {
        
        let lineView = UIView()
        lineView.backgroundColor = hexColor("ebebf1")
        return lineView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTap))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension WLTBuddhistTableViewCell {

    fileprivate func setupUI() {
        
        // 1.添加封面
        addSubview(musicCoverImage)
        musicCoverImage.snp.makeConstraints { (musicCoverImage) in
            
            musicCoverImage.left.equalTo(15)
            musicCoverImage.top.equalTo(16)
            musicCoverImage.width.equalTo(59)
            musicCoverImage.height.equalTo(59)
        }
        
        // 2.音乐标题
        addSubview(musicTittle)
        musicTittle.snp.makeConstraints { (musicTittle) in
            
            musicTittle.left.equalTo(musicCoverImage.snp.right).offset(9)
            musicTittle.top.equalTo(musicCoverImage.snp.top).offset(8)
            musicTittle.height.equalTo(15)
        }

        // 3.音乐描述
        addSubview(musicDescribe)
        musicDescribe.snp.makeConstraints { (musicDescribe) in
            
            musicDescribe.left.equalTo(musicCoverImage.snp.right).offset(9)
            musicDescribe.top.equalTo(musicTittle.snp.bottom).offset(11)
            musicDescribe.right.equalTo(-40)
            musicDescribe.height.equalTo(13)
        }
        
//        // 4.集数的iocn
//        addSubview(musicGatherIcon)
//        musicGatherIcon.snp.makeConstraints { (musicGatherIcon) in
//            
//            musicGatherIcon.top.equalTo(musicDescribe.snp.bottom).offset(8)
//            musicGatherIcon.left.equalTo(musicCoverImage.snp.right).offset(9)
//            musicGatherIcon.height.equalTo(13)
//            musicGatherIcon.width.equalTo(13)
//        }
//
//        // 4.1集数
//        addSubview(musicGather)
//        musicGather.snp.makeConstraints { (musicGather) in
//            
//            musicGather.top.equalTo(musicGatherIcon.snp.top)
//            musicGather.left.equalTo(musicGatherIcon.snp.right).offset(6)
//            musicGather.bottom.equalTo(musicGatherIcon.snp.bottom)
//            musicGather.width.equalTo(30)
//        }
        

        // 5.下载次数icon
        addSubview(musicHearIcon)
        musicHearIcon.snp.makeConstraints { (musicHearIcon) in
            
            musicHearIcon.left.equalTo(musicCoverImage.snp.right).offset(9)
            musicHearIcon.top.equalTo(musicDescribe.snp.bottom).offset(8)
            musicHearIcon.height.equalTo(13)
            musicHearIcon.width.equalTo(13)
        }
        
        // 5.1下载标题
        addSubview(musicHearNum)
        musicHearNum.snp.makeConstraints { (musicHearNum) in
            musicHearNum.top.equalTo(musicHearIcon.snp.top)
            musicHearNum.left.equalTo(musicHearIcon.snp.right).offset(6)
            musicHearNum.bottom.equalTo(musicHearIcon.snp.bottom)
        }
        
        // 6.添加分割线
        addSubview(lineView)
        lineView.snp.makeConstraints { (lineView) in
            
            lineView.left.equalTo(musicCoverImage.snp.right).offset(9)
            lineView.height.equalTo(1)
            lineView.right.equalTo(-15)
            lineView.bottom.equalTo(0)
        }
    }
    
    func viewTap() {
        delegate?.clickCell(self.tag)
    }
    
}







