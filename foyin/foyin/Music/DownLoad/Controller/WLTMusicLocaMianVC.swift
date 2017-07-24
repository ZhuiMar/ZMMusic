//
//  WLTMusicLocaMianVC.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/7/10.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit

class WLTMusicLocaMianVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setChildVC()
        navigationItem.title = "我的佛音"
    }
}


// MARK: 创建子控制器

extension WLTMusicLocaMianVC {
    
    func setChildVC() {
        
        automaticallyAdjustsScrollViewInsets = false
        
        let pageFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        let tittles = ["我的音乐", "下载任务"]
        var childVcs = [UIViewController]()
        var style = ZYPageStyle()
        style.isScrollEnable = false
        style.isNeedScale = false
        style.isShowCoverView = true
        style.isShowBottomLine = false
        
        let localVC = WLTMusicLocalVC()
        let downVC = WLTMusicDownVC()
        
        childVcs.append(localVC)
        childVcs.append(downVC)
        
        let pageView  =  ZYPageView(frame: pageFrame, tittles: tittles, style: style, childVcs: childVcs, parentVc: self, currentPage: 0)
        self.view.addSubview(pageView)
    }
}
