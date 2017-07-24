//
//  WLTMainMusicListVC.swift
//  foyin
//
//  Created by  luzhaoyang on 17/6/17.
//  Copyright © 2017年 Kingstong. All rights reserved.
//

import UIKit

class WLTMainMusicListVC: UIViewController {

    fileprivate var currentPage: Int!
    
    init?(currentPage: Int){
        self.currentPage = currentPage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        let pageFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        let tittles = ["佛教音乐","听闻佛事","智慧开示"]
        var childVcs = [UIViewController]()
        var style = ZYPageStyle()
        style.isScrollEnable = false
        style.isNeedScale = false
        style.isShowCoverView = false
        style.isShowBottomLine = true
        
        let BuddhistMusicVC = WLTBuddhistMusicVC()
        BuddhistMusicVC.type = 0
        
        let HeardBuddhistVC = WLTHeardBuddhistVC()
        HeardBuddhistVC.type = 3
        
        let WisdomRevealVC = WLTWisdomRevealVC()
        WisdomRevealVC.type = 5
        
        childVcs.append(BuddhistMusicVC)
        childVcs.append(HeardBuddhistVC)
        childVcs.append(WisdomRevealVC)
        
        let pageView  =  ZYPageView(frame: pageFrame, tittles: tittles, style: style, childVcs: childVcs, parentVc: self, currentPage: currentPage)
        self.view.addSubview(pageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
