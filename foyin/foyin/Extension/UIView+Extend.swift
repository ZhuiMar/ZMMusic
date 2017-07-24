//
//  UIView+Extend.swift
//  WXYourSister
//
//  Created by 魏翔 on 16/6/21.
//  Copyright © 2016年 魏翔. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /**  size  */
    var size: CGSize{
        
        get{
            return self.frame.size
        }
        
        set{
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    
    }
    
    /**  width  */
    var width: CGFloat {
        
        get{
            return self.size.width
        }
        set{
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        
    }
    
    /**  height  */
    var height: CGFloat {
        get{
            return self.frame.size.height
        }
        set{
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    /**  x  */
    var x: CGFloat {
        
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        
        get{
            return self.frame.origin.x
        }
    }
    
    /**  y  */
    var y: CGFloat {
        
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        
        get{
            return self.frame.origin.y
        }
    }
    
    /** centerX */
    var centerX: CGFloat{
        set{
            var center = self.center
            center.x = newValue
            self.center = center
        }
        get{
            return self.center.x
        }
    }
    
    /** centerY */
    var centerY: CGFloat{
        get{
            return self.center.y
        }
        set{
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    
    /**  添加边框  */
    func border(width: CGFloat, color: UIColor){
        
        self.layer.borderWidth = width
        
        self.layer.borderColor = color.cgColor
    }
    
    /**  添加边框  */
    func addShadow(color: UIColor,offset: CGSize,opacity: Float ){
        
        self.layer.borderColor = color.cgColor
        
        self.layer.shadowOffset = offset
        
        self.layer.shadowOpacity = opacity
        
        
    }
    /// 设置圆角
    ///
    /// - Parameter radius: 圆角半径
    func addCornerRadius(radius: CGFloat){
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    /** 从xib中加载View*/
    class func viewInitWithNib() -> UIView{
        return Bundle.main.loadNibNamed(stringFromClass(self)!, owner: nil, options: nil)!.last as! UIView
    }
    
    // MARK: 转换播放时间
    func convertStringWithTime(_ time: Float) -> String{
        
        // print(time)
        let min = Int(time / 60.0)
        let sec = Int(time - Float(min * 60))
        let minStr = min > 9 ? NSString(format: "%d", min) : NSString(format: "0%d", min)
        let secStr = sec > 9 ? NSString(format: "%d", sec) : NSString(format: "0%d", sec)
        let timeStr = "\(minStr):\(secStr)"
        return timeStr
    }
}
