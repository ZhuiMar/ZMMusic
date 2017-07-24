//
//  WXNavVC.swift
//  WXYourSister
//
//  Created by 魏翔 on 16/6/15.
//  Copyright © 2016年 魏翔. All rights reserved.
//

import UIKit

class WXNavVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareForNavigationBar() // 首次提交测试
    }
    
    func prepareForNavigationBar(){
        
        let bar = UINavigationBar.appearance()
        bar.tintColor = UIColor.white
        bar.barTintColor = APPTintColor_Brown
        bar.setBackgroundImage(UIImage.imageWithColor(color: APPTintColor_Brown, size: CGSize(width: 1.0,height: 1.0)), for: UIBarMetrics.default)
        bar.titleTextAttributes = [NSFontAttributeName:UIFont(name: "PingFangSC-Regular", size: 17)!,NSForegroundColorAttributeName: UIColor.white]
        
        let target = self.interactivePopGestureRecognizer!.delegate
        let pan = UIPanGestureRecognizer(target:target,
                                         action:Selector(("handleNavigationTransition:")))
        pan.delegate = self
        self.view.addGestureRecognizer(pan)
        //同时禁用系统原先的侧滑返回功能
        self.interactivePopGestureRecognizer!.isEnabled = false
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if(childViewControllers.count > 0) {
            
            viewController.hidesBottomBarWhenPushed = true
            let backBtn = UIButton()
            backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0)
            backBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 44)
            backBtn.setTitleColor(APPTabBar_Color, for: UIControlState.highlighted)
            backBtn.setTitleColor(UIColor.black, for: UIControlState())
            backBtn.setImage(UIImage(named: "fanhui"), for: UIControlState())
            
            
            backBtn.addTarget(self, action: #selector(WXNavVC.didClickBackVC), for: UIControlEvents.touchUpInside)
            

            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func didClickBackVC() {
        popViewController(animated: true)
    }
    
    func didClickBackRootVC(){
        popToRootViewController(animated: true)
    }
}


// 添加的测滑的手势
extension WXNavVC : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UIPanGestureRecognizer {
            let point = (gestureRecognizer as! UIPanGestureRecognizer).translation(in: gestureRecognizer.view)
            if point.y != 0 {
                return false
            }
        }
        if self.childViewControllers.count == 1 {
            return false
        }
       
        return true
    }
}


// MARK: 状态栏的颜色
extension WXNavVC  {

    func addEdgeGesture() {
        
        // 校验手势是否存在(这个手势包含target 和 action)
        guard let interactionGes = interactivePopGestureRecognizer else { return }
    
        // 运行时取出属性
//        var count: UInt32 = 0
//        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)
//        for i in 0..<count {
//            let ivar = ivars[i]
//            let nameP = ivar_getName(ivar)
//            let name = String(cString: nameP!)
//            print(name)
//        }
        
        guard let values = interactionGes.value(forKeyPath: "_targets") as? [AnyObject]  else { return }
        guard let object = values.first else { return }
        
        // 取出action 和 target 
        let target = object.value(forKeyPath: "target")
        let action = Selector("handleNavigationTransition:")
        
        // 创建我们自己的手势
        let panGes = UIPanGestureRecognizer(target: target, action: action)
        view.addGestureRecognizer(panGes)
    
    }
}









