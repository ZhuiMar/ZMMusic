//
//  WLTMusicePresentVC.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/5/16.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class WLTMusicePresentVC: UIPresentationController {

    // MARK: 懒加载
    fileprivate lazy var coverView : UIView = UIView()
    
    // MARK: 系统的回调
    override func containerViewWillLayoutSubviews() { // 容器的View即将布局子控件
        super.containerViewWillLayoutSubviews()
        
        // 调整被弹出的View的一个尺寸
        presentedView?.frame = CGRect(x: 0, y:  UIScreen.main.bounds.height/3, width: kScreenWidth, height: UIScreen.main.bounds.height * 2/3)
        setupCoverView()
    }
    
    
}


// MARK : 设置我们界面相关
extension WLTMusicePresentVC {
    
    fileprivate func setupCoverView() {
        
        // 添加蒙版
        containerView?.insertSubview(coverView, at: 0)
        
        // 设置蒙版的属性
        coverView.backgroundColor = UIColor(white: 0.0, alpha: 0.6)
        
        coverView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        
        // 添加手势
        let tapGes = UITapGestureRecognizer(target: self, action:#selector(clickTap))
        
        coverView.addGestureRecognizer(tapGes)
        
        NotificationCenter.default.addObserver(self, selector: #selector(WLTMusicePresentVC.closeAction(_:)), name: Notification.Name(rawValue: "WLTMusicePresentVCClose"), object: nil)
    }
}


// MARK : 监听点击事件
extension WLTMusicePresentVC {
    func clickTap() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    func closeAction(_ notification: NSNotification) {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}

