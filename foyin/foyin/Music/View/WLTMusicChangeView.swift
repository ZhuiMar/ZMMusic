//
//  WLTMusicChangeView.swift
//  佛音
//
//  Created by  luzhaoyang on 17/6/15.
//  Copyright © 2017年 Kingstong. All rights reserved.
//

import UIKit

protocol WLTMusicChangeViewDelagate {
    
    func changeView(_ changeView: WLTMusicChangeView, style: musicType)
}

class WLTMusicChangeView: UIView {

    fileprivate var type: musicType!
    var delegate: WLTMusicChangeViewDelagate?
    
    fileprivate lazy var label: UILabel = {
        let rect = CGRect(x: 0, y: 0, width: self.frame.size.width - self.frame.size.height, height: self.frame.size.height)
        let label = UILabel(frame: rect)
        label.text = "换一批"
        label.textColor = hexColor("777777")
        label.textAlignment = .center
        label.font = UIFont(name: "PingFangSC-Medium", size: 12)
        return label
    }()
    
    fileprivate lazy var image: UIImageView = {
        let rect = CGRect(x: self.frame.size.width - self.frame.size.height, y: 0, width: self.frame.size.height, height: self.frame.size.height)
        let image = UIImageView(frame: rect)
        image.image = UIImage(named: "music_exchange")
        return image
    }()
    
    fileprivate lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        let rect = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        button.frame = rect
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(WLTMusicChangeView.clickChangeBtnAction), for: .touchUpInside)
        return button
    }()
    
    
    init(frame: CGRect, style: musicType) {
        self.type = style
        super.init(frame: frame)
        setupUI()
        addForeImageViewAddAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: 设置Ui
extension WLTMusicChangeView {
    
    fileprivate func setupUI() {
        addSubview(self.label)
        addSubview(self.image)
        addSubview(self.button)
    }
}


// MARK: 换一换
extension WLTMusicChangeView {

    func clickChangeBtnAction() {
        delegate?.changeView(self, style: self.type)
    }
}


extension WLTMusicChangeView {
    
    func addForeImageViewAddAnimation() -> () {
        image.layer.removeAnimation(forKey: "foreImageViewRotationAnimation")
        let anaimation = CABasicAnimation(keyPath: "transform.rotation.z")
        anaimation.fromValue = 0
        anaimation.toValue = M_PI * 2
        anaimation.duration = 1
        anaimation.repeatCount = MAXFLOAT
        anaimation.isRemovedOnCompletion = false
        image.layer.add(anaimation, forKey: "foreImageViewRotationAnimation")
        revealStop()
    }
    
    func revealPlay() {
        image.layer.resumeAnimation()
    }
    
    func revealStop() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
             self.image.layer.pauseAnimation()
        }
    }
}


