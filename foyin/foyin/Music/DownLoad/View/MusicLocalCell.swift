//
//  MusicLocalCell.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/7/10.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit
import SDWebImage

protocol MusicLocalCellDelegate {
    func singleDelegate()
}


class MusicLocalCell: UITableViewCell {
    
    var delegate: MusicLocalCellDelegate?
    
    fileprivate lazy var coverImage: UIImageView = {
        
        let coverImage = UIImageView()
        coverImage.layer.shadowOpacity = 0.5
        coverImage.layer.shadowColor = UIColor.black.cgColor
        coverImage.layer.shadowOffset = CGSize(width: 1, height: 1)
        return coverImage
    }()
    
    fileprivate lazy var deleteButton: UIButton = {
        
        let deleteButton = UIButton(type: .system)
        deleteButton.addTarget(self, action: #selector(MusicLocalCell.singleDeleteLocalMusic), for: .touchUpInside)
        deleteButton.setBackgroundImage(UIImage(named:"deleteIcon"), for: .normal)
        deleteButton.titleLabel?.font = UIFont(name: "PingFangSC-Regular", size: 14)
        return deleteButton
    }()
    
    fileprivate lazy var tittleLabel: UILabel = {
        
        let tittleLabel = UILabel()
        tittleLabel.textColor = hexColor("333333")
        tittleLabel.font = UIFont.systemFont(ofSize: 14)
        return tittleLabel
    }()
    
    fileprivate lazy var lineView: UIView = {
        
        let lineView = UIView()
        lineView.backgroundColor = rgb(235, g: 235, b: 241, a: 1.0)
        return lineView
    }()

    var model: SoundModel? {
        
        didSet{
            guard let urlStr = model?.fileCover else {
                return
            }
            coverImage.kf.setImage(with: URL(string: (urlStr)))
            tittleLabel.text = model?.fileTitle
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MusicLocalCell {
    
    func singleDeleteLocalMusic(){
        
        // 删掉目录中的文件
        let fileManager = FileManager.default
        let fileURL = URL(fileURLWithPath: (model?.filePath.musicDir())!)
        
        do{
            try?fileManager.removeItem(at: fileURL)
            let musicDao = MusicDao()
            musicDao.delMusic(id: "\(model!.id)")
        }
        
        model?.isDownLoad = false
        delegate?.singleDelegate()
        
        // 通知刷新UI
        NotificationCenter.default.post(name: Notification.Name(rawValue: "MusicRefreshUI"), object: height)
    }
}



extension MusicLocalCell {
    
    func setupUI() {
        
        addSubview(coverImage)
        coverImage.snp.makeConstraints { (coverImage) in
            
            coverImage.top.equalTo(10)
            coverImage.height.equalTo(40)
            coverImage.width.equalTo(40)
            coverImage.left.equalTo(15)
        }
        
        addSubview(lineView)
        lineView.snp.makeConstraints { (lineView) in
            
            lineView.left.right.equalTo(60)
            lineView.right.equalTo(0)
            lineView.height.equalTo(0.5)
            lineView.bottom.equalTo(0)
        }
        
        addSubview(tittleLabel)
        tittleLabel.snp.makeConstraints { (tittleLabel) in
            
            tittleLabel.left.equalTo(coverImage.snp.right).offset(15)
            tittleLabel.height.equalTo(14)
            tittleLabel.right.equalTo(-50)
            tittleLabel.centerY.equalTo(coverImage.snp.centerY)
        }
        
        contentView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { (deleteButton) in
            
            deleteButton.centerY.equalTo(self.snp.centerY)
            deleteButton.right.equalTo(-15)
            deleteButton.width.equalTo(25)
            deleteButton.height.equalTo(25)
        }
    }
}
