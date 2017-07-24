//
//  NSCalendar+Extend.swift
//  CalederTest
//
//  Created by 魏翔 on 16/6/21.
//  Copyright © 2016年 魏翔. All rights reserved.
//

import Foundation

extension Date{
    
    /**是否是去年*/
    func isThisYear()->Bool{
        
        let nowYear = (Calendar.current as NSCalendar).component(.year, from: Date())
        
        let selfYear = (Calendar.current as NSCalendar).component(.year, from: self)
        
        return nowYear == selfYear
    }
    
    /**是否是今天*/
    func isToday()->Bool{
        
        return Calendar.current.isDateInToday(self)
        
    }
    
    /**是否是昨天*/
    func isYesterDay()->Bool{
        
        return Calendar.current.isDateInYesterday(self)
        
    }
    
    func deltaFrom(_ from: Date)->DateComponents{
        
        let calendar = Calendar.current
        
        return (calendar as NSCalendar).components([NSCalendar.Unit.day,NSCalendar.Unit.month,NSCalendar.Unit.year,NSCalendar.Unit.hour,NSCalendar.Unit.minute,NSCalendar.Unit.second], from: from, to: self, options: NSCalendar.Options.matchFirst)
    }
    
    /**判断两个日期是否相差在1分钟内*/
    func isIn1Minute()->Bool{
        
        let timerInterval1 = self.timeIntervalSince1970
        
        let timerInterVal2 = Date().timeIntervalSince1970
        
        return abs(timerInterVal2 - timerInterval1)/60 < 1
        
    }    
    
    /**判断两个日期是否相差在1小时内*/
    
    func isIn1Hour()->Bool{
        
        let timerInterval1 = self.timeIntervalSince1970
        
        let timerInterVal2 = Date().timeIntervalSince1970
        
        return abs(timerInterVal2 - timerInterval1)/3600 < 1
        
    }
    
    /** 获取今天day */
    static func getToDay()->Int{
        
        return dateComponents().day!
        
    }
    
    /** 获取今天月份 */
    static func getToMonth()->Int {
        return dateComponents().month!
    }
    
    /** 获取今天月份 */
    static func getToYear()->Int {
        return dateComponents().year!
    }
    
    static func dateComponents()->DateComponents{
        
        let nowDate = Date()
        
        let calendar = Calendar.current
        
        let dateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.year,NSCalendar.Unit.month,NSCalendar.Unit.day,NSCalendar.Unit.hour,NSCalendar.Unit.minute,NSCalendar.Unit.second], from: nowDate)
        
        return dateComponents
    }
}
