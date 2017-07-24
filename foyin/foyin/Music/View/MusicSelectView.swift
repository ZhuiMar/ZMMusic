//
//  MusicSelectView.swift
//  佛音
//
//  Created by  luzhaoyang on 17/6/15.
//  Copyright © 2017年 Kingstong. All rights reserved.
//

import UIKit


protocol MusicSelectViewDelegate {
    func jumpToNextVC(selectView: MusicSelectView, tag: Int)
}

class MusicSelectView: UIView {

    var delegate: MusicSelectViewDelegate?
    fileprivate var titiles: [String] = ["佛教音乐", "听闻佛事", "智慧开示"]
    
    
    class func clone() -> MusicSelectView {
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 34)
        let view = MusicSelectView(frame: rect)
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


extension MusicSelectView {

    func setupUI () {
    
        self.backgroundColor = UIColor.white
        
        for i in 0..<titiles.count {
            let btn = UIButton(type: .custom)
            let btnX = width/3 * CGFloat(i)
            let btnW = width/3
            btn.frame = CGRect(x: btnX, y: 0, width: btnW, height: 34)
            btn.setTitle(titiles[i], for: .normal)
            btn.titleLabel?.font = UIFont(name: "PingFangSC-Medium", size: 14)
            btn.setTitleColor(hexColor("333333"), for: .normal)
            btn.addTarget(self, action: #selector(clickBtnAction(_:)), for: .touchUpInside)
            btn.tag = i
            self.addSubview(btn)
        }
    }
    

    func clickBtnAction(_ button: UIButton) {
        let tag = button.tag
        delegate?.jumpToNextVC(selectView: self, tag: tag)
    }

    
}
