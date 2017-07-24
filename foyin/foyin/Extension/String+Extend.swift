//
//  String+Extend.swift
//  WXYourSister
//
//  Created by 魏翔 on 16/6/21.
//  Copyright © 2016年 魏翔. All rights reserved.
//

import Foundation

func stringFromClass(_ cls: AnyClass)->String?{
    
    let string = NSStringFromClass(cls.self).components(separatedBy: ".").last
    return string
}

extension String{
    
    /** 
     将当前字符串拼接到Music目录后面
     */
    func musicDir() -> String{
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!  as NSString
        return (path.appendingPathComponent("Music") as NSString).appendingPathComponent((self as NSString).lastPathComponent)
    }
    /**
     将当前字符串拼接到cache目录后面
     */
    func cacheDir() -> String{
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!  as NSString
        return path.appendingPathComponent((self as NSString).lastPathComponent)
    }
    /**
     将当前字符串拼接到doc目录后面
     */
    func docDir() -> String
    {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!  as NSString
        return path.appendingPathComponent((self as NSString).lastPathComponent)
    }
    /**
     将当前字符串拼接到tmp目录后面
     */
    func tmpDir() -> String
    {
        let path = NSTemporaryDirectory() as NSString
        return path.appendingPathComponent((self as NSString).lastPathComponent)
    }
    /**
     将用于显示的string变attributeString
     */
    func attributeTextWithColor(color: UIColor,range: NSRange) -> NSAttributedString{
        let attrStr = NSMutableAttributedString(string: self)
        attrStr.addAttribute(NSForegroundColorAttributeName, value: color,range: range)
        return attrStr
    }

}

extension String {
    
    func strHeightWith(_ fontSize: CGFloat,maxWidth: CGFloat)-> CGFloat{
        
        //根据属性计算text的高度 UIFont(name: "PingFangSC-Regular", size: 14)
        //let att = [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)]
        let att = [NSFontAttributeName: UIFont(name: "PingFangSC-Regular", size: fontSize)]
        
        //文字最大尺寸
        let maxSize: CGSize = CGSize(width: maxWidth, height: CGFloat(MAXFLOAT))
        let opt = NSStringDrawingOptions.usesLineFragmentOrigin
        return self.boundingRect(with: (maxSize), options: opt, attributes: att, context: nil).size.height
    }
    
    static func addUnit(_ count: Int) -> String {
        
        if count >= 10000 {
            
            let conutStr = "\(count)"
            let newStr = conutStr as NSString
            let integer = newStr.substring(with: NSRange(location: 0, length: 1))
            let decimal = newStr.substring(with: NSRange(location: 1, length: 2))
            return integer + "." + decimal + "万"
            
        }else{
            
            return "\(count)"
        }
    }
    
}

extension String{
    
//    /** Md5加密 */
//    var md5 : String{
//        let str = self.cString(using: String.Encoding.utf8)
//        
//        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
//        
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//        
//        CC_MD5(str!, strLen, result)
//        
//        let hash = NSMutableString()
//        
//        for i in 0 ..< digestLen {
//            hash.appendFormat("%02x", result[i]);
//        }
//        
//        result.deinitialize()
//        return String(format: hash as String)
//    }
    
    func dateStringWith(_ formatterStr: String)->String{
        
        let dateformatter = DateFormatter()

        dateformatter.dateFormat = formatterStr
        
        let date = dateformatter.date(from: self)!
        
        if date.isThisYear(){//今年
            
            if date.isToday(){//今天
                
                let cmps = Date().deltaFrom(date)
                
                if cmps.hour! >= 1{
                    return "\(cmps.hour!)小时前"
                    
                }else if cmps.minute! >= 1{
                    
                    return "\(cmps.minute!)分钟前"
                    
                }else{
                    return "刚刚"
                }
                
            }else if date.isYesterDay(){ //昨天
                
                dateformatter.dateFormat = "昨天 HH:mm:ss"
                
                return dateformatter.string(from: date)
                
            }else{
                
                dateformatter.dateFormat = "MM-dd HH:mm:ss"
                //不显示年
                return dateformatter.string(from: date)
            }
            
        }else{//非今年
            
            return self
            
        }
        
    }
    
    /** 时间戳转格式化的时间字符串 */
    func timestamp(format: String) -> String {
        
        if self.isEmpty {return self}
        let date = Date(timeIntervalSince1970: Double(Int(self)!))
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    /*把时间戳转换为时间*/
    func stringWithTimeStamp(with format: String)->String {
        
        let index = self.index(self.endIndex, offsetBy: -3)
        let string:NSString=self.substring(to: index) as NSString
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = format
        let date = Date(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date)
    }
    
    /** 
     去掉小数点后的字符串
     "1234566.0" => "1234566"
     */
    func strWithOutDotZero()->String{
        
        var outNumber = self
        
        var i = 1
        
        if self.contains("."){
            while i < self.characters.count{
                if outNumber.hasSuffix("0"){
                    outNumber.remove(at: outNumber.characters.index(before: outNumber.endIndex))
                    i = i + 1
                }else{
                    break
                }
            }
            if outNumber.hasSuffix("."){
                outNumber.remove(at: outNumber.characters.index(before: outNumber.endIndex))
            }
            return outNumber
        }
        else{
            return self
        }
    }
    
    /**
     将{'a':'20'}这种类型的字符串转化为20字符串
     */
    func numerStr()->String{
        
        let aStr = self.components(separatedBy: ":").last!
        
        let bStr = aStr.replacingOccurrences(of: "}", with: "")
        
        return bStr.replacingOccurrences(of: "'", with: "")

    }
    
    /** 获取系统当前时间 */
    func sysTimeStr() -> String{
        
        let date = Date()
        
        let timeFormmatter = DateFormatter()
        
        timeFormmatter.dateFormat = "yyy-MM-dd 'at' HH:mm:ss.SSS"
        
        return timeFormmatter.string(from: date) as String
    }

    /**设置string 行间距*/
    func attributeStr(with lineSpace: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)

        let paragraphStye = NSMutableParagraphStyle()
        paragraphStye.lineSpacing = lineSpace
      
        let range = NSMakeRange(0, CFStringGetLength(self as CFString!))
        attributedString .addAttribute(NSParagraphStyleAttributeName, value: paragraphStye, range: range)
        
            return attributedString
    }
    
    /*设置string字体*/
    func fontAttributeStr(with fontSize:CGFloat) -> NSAttributedString{
    
        let attributeString = NSMutableAttributedString(string: self)
        
        let range = NSMakeRange(0, CFStringGetLength(self as CFString!))
        
        attributeString.addAttribute(NSParagraphStyleAttributeName, value: UIFont(name: "PingFangSC-Regular", size: fontSize)!, range: range)
        
        return attributeString
    }
    
    /*url中文转换*/
    func convertChineseByPercentEncoding() -> String?{
        
                let convertedUrl = self.removingPercentEncoding!
                
                return convertedUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }

    //判断字符串是否包含中文
    func isIncludeChineseIn() -> Bool {
        
        for (_, value) in self.characters.enumerated() {
            
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        
        return false
    }
    //将range转化为NSRange
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
    }
    
    func changeTextColor(text: String, color: UIColor, range: NSRange) -> NSAttributedString {
        let attributeStr = NSMutableAttributedString(string: text)
        attributeStr.addAttribute(NSForegroundColorAttributeName, value:color , range: range)
        
        return attributeStr
    }
    
        
}

extension String {
    
    var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case
            0x00A0...0x00AF,
            0x2030...0x204F,
            0x2120...0x213F,
            0x2190...0x21AF,
            0x2310...0x329F,
            0x1F000...0x1F9CF:
                return true
            default:
                continue
            }
        }
        return false
    }
    
}
