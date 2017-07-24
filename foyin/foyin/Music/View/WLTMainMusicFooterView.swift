//
//  WLTMainMusicFooterView.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/6/13.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit

protocol FooterVieDelegate {
    // 跳往更多的代理
    func wisdomRevealMore(_ tag: Int)
    func wisdomRevealDetail(_ musicModel: SoundModel)
}


class WLTMainMusicFooterView: UIView {
    
    var delegate:FooterVieDelegate?
    
    fileprivate lazy var gridView: WLTMusicGridView = {
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 405 + 12 )
        let gridView = WLTMusicGridView(frame: rect, title: musicType.wisdomReveal.rawValue, actionTitle: "更多", type: 5)
        gridView.backgroundColor = UIColor.clear
        gridView.titleLabelView.delegate = self
        gridView.delegate = self
        return gridView
    }()
    
    fileprivate lazy var changeView: WLTMusicChangeView = {
        let rect = CGRect(x: (UIScreen.main.bounds.width - 60)/2, y: self.frame.size.height - 16 - 12, width: 60, height: 12)
        let changeView = WLTMusicChangeView(frame: rect, style: musicType.headerBuddhist)
        changeView.delegate = self
        return changeView
    }()
    
    class func clone() -> WLTMainMusicFooterView {
        let view = WLTMainMusicFooterView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 405 + 35))
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        getData()
        getrandomData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: 设置UI
extension WLTMainMusicFooterView {

    fileprivate func setupUI() {
        addSubview(gridView)  // 1.添加格子
        addSubview(changeView) // 2.换一批
    }
}


// 获取数据
extension WLTMainMusicFooterView {

    // 获取智慧开示
    fileprivate func getData() {
        WLTMusicHttpTool.getMusicRecommendData(musicType: 5) { (models) in
            self.gridView.wisdomDataArr = models
        }
    }
    
    // 随机获取智慧开示
    fileprivate func getrandomData() {
        
        changeView.revealPlay()
        WLTMusicHttpTool.getMusicRandomData(musicType: 5) { (models) in
            self.gridView.wisdomDataArr = models
            self.changeView.revealStop()
        }
    }
}


// MARK: 换衣批
extension WLTMainMusicFooterView: WLTMusicChangeViewDelagate {
    
    
    func changeView(_ changeView: WLTMusicChangeView, style: musicType) {
        
        if style == musicType.headerBuddhist {
            getrandomData()
        }
    }
}


// MARK: 更多
extension WLTMainMusicFooterView: WLTMusicTitleViewDelegate {
    
    func musicTitleView(_ musicTitleView: WLTMusicTitleView, title: String) {
        if title == "智慧开示" {
            delegate?.wisdomRevealMore(2)
        }
    }
}


// MARK: 九宫格的代理
extension WLTMainMusicFooterView: WLTMusicGridViewDelegate {
    
    func musicGridView(_ musicGrid: WLTMusicGridView, musicModel: SoundModel) {
        delegate?.wisdomRevealDetail(musicModel)
    }
}






