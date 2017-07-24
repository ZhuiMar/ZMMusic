//
//  MusicListCell.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/7/6.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit
import SnapKit

class MusicListCell: UITableViewCell {
    
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
    
    lazy var serial: UIButton = {
        
        let serial = UIButton(type: .custom)
        serial.setTitleColor(hexColor("333333"), for: .normal)
        serial.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return serial
    }()
    
    var model: SoundModel? {
        didSet{
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


extension MusicListCell {

    func setupUI() {
        
        addSubview(lineView)
        lineView.snp.makeConstraints { (lineView) in
            
            lineView.left.right.equalTo(45)
            lineView.right.equalTo(0)
            lineView.height.equalTo(0.5)
            lineView.bottom.equalTo(0)
        }
        
        addSubview(serial)
        serial.snp.makeConstraints { (serial) in
            
            serial.centerY.equalTo(self.snp.centerY)
            serial.height.equalTo(15)
            serial.width.equalTo(15)
            serial.left.equalTo(15)
        }
        
        addSubview(tittleLabel)
        tittleLabel.snp.makeConstraints { (tittleLabel) in
            
            tittleLabel.left.equalTo(serial.snp.right).offset(15)
            tittleLabel.height.equalTo(14)
            tittleLabel.right.equalTo(-50)
            tittleLabel.centerY.equalTo(serial.snp.centerY)
        }
    }
}



extension MusicListCell {

    
}




