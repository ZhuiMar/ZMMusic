//
//  WLTMainMusicHeaderView.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/6/13.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate {
    
    func buddhistMoreJump(_ tag: Int)
    func buddhistDetialJump(_ musicModel: SoundModel)
    func bannerJumpToNext(_ model: MusicBannerModel)
}

class WLTMainMusicHeaderView: UIView {
    
    var delegate:HeaderViewDelegate?
    
    fileprivate lazy var cycleScrollerView: SDCycleScrollView = {
        let rect = CGRect(x:0, y:0,width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width*8/15)
        let placehimage = UIImage(named: "loading_cover")
        let cycleScrollerView = SDCycleScrollView(frame: rect, delegate: self, placeholderImage: placehimage)
        cycleScrollerView?.autoScrollTimeInterval = 5.0
        cycleScrollerView?.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
        return cycleScrollerView!
    }()
    
    fileprivate lazy var gridView: WLTMusicGridView = {
        let rect = CGRect(x: 0, y: UIScreen.main.bounds.width*8/15, width: UIScreen.main.bounds.width, height: 405)
        let gridView = WLTMusicGridView(frame: rect, title: musicType.buddhist.rawValue, actionTitle: "更多", type: 0)
        gridView.backgroundColor = UIColor.clear
        gridView.titleLabelView.delegate = self
        gridView.delegate = self
        return gridView
    }()
    
    fileprivate lazy var changeView: WLTMusicChangeView = {
        let rect = CGRect(x: (UIScreen.main.bounds.width - 60)/2, y: self.frame.size.height - 12 - 16, width: 60, height: 12)
        let changeView = WLTMusicChangeView(frame: rect, style: musicType.buddhist)
        changeView.delegate = self
        return changeView
    }()
    
    fileprivate lazy var bannerModels: [MusicBannerModel] = []
    
    class func clone() ->WLTMainMusicHeaderView {
        let view = WLTMainMusicHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 405 + UIScreen.main.bounds.width*8/15 + 25))
        return view
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        getBannerData()
        getRecommendData()
        getrandomData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: 设置UI
extension WLTMainMusicHeaderView {
    
    fileprivate func getBannerData() {
        WLTMusicHttpTool.getMusicBannerData(success: { (models) in
            
            self.bannerModels = models
            
            var imageUrlArr: [String] = []
            
            for i in 0..<models.count {
                let model = models[i] as MusicBannerModel
                let path = model.imgPath
                imageUrlArr.append(path)
            }
            
            print(imageUrlArr)
            self.cycleScrollerView.localizationImageNamesGroup = imageUrlArr
        })
    }
    
   // 获取推荐音乐
   fileprivate func getRecommendData() {
        WLTMusicHttpTool.getMusicRecommendData(musicType: 0) { (models) in
            self.gridView.recommendDataArr = models
        }
    }
    
   // 随机获取随机推荐
   fileprivate func getrandomData() {
        changeView.revealPlay()
        WLTMusicHttpTool.getMusicRandomData(musicType: 0) { (models) in
            self.gridView.recommendDataArr = models
            self.changeView.revealStop()
        }
   }
    
}


// MARK: 设置UI
extension WLTMainMusicHeaderView {
    
    fileprivate func setupUI() {
    
        // 1.创建滚动视图
        addSubview(cycleScrollerView)
        
        // 2.创建九宫格
        addSubview(gridView)
        
        // 3.换一批
        addSubview(changeView)
    }
}




// MARK: 点击轮播图
extension WLTMainMusicHeaderView: SDCycleScrollViewDelegate {
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        
        let model = self.bannerModels[index]
        delegate?.bannerJumpToNext(model)
    }
}


// MARK: 换衣批
extension WLTMainMusicHeaderView: WLTMusicChangeViewDelagate {
    
    func changeView(_ changeView: WLTMusicChangeView, style: musicType) {
        if style == musicType.buddhist {
            getrandomData()
        }
    }
}


// MARK: 更多
extension WLTMainMusicHeaderView: WLTMusicTitleViewDelegate {
    
    func musicTitleView(_ musicTitleView: WLTMusicTitleView, title: String) {
        if title == "推荐" {
            delegate?.buddhistMoreJump(0)
        }
    }
}


// MARK: 九宫格的代理
extension WLTMainMusicHeaderView: WLTMusicGridViewDelegate {
    
    func musicGridView(_ musicGrid: WLTMusicGridView, musicModel: SoundModel) {
        delegate?.buddhistDetialJump(musicModel)
    }
}




