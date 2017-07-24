
//
//  UIImage+Extend.swift
//  WXYourSister
//
//  Created by 魏翔 on 16/7/20.
//  Copyright © 2016年 魏翔. All rights reserved.
//

import UIKit


//水印位置枚举
enum WaterMarkCorner{
    case TopLeft
    case TopRight
    case BottomLeft
    case BottomRight
}

extension UIImage{
    
    
    func clipImageWith(borderColor color: UIColor?, borderWidth borderW: CGFloat?)->UIImage{

        let borderW:CGFloat = (borderW == nil) ? 5 : borderW! // 设置外圆环宽度
        let loopColor = (color == nil) ? UIColor.red : color!  // 设置外圆环颜色
        let borderWH:CGFloat = size.width + 2*borderW // 设置外圆宽高
        let imageContextSize = CGSize(width: borderWH,height: borderWH)  // 设置图形上下文大小
        UIGraphicsBeginImageContext(imageContextSize) // 开启图形上下文
        let circlePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: borderWH, height: borderWH)) // 设置外圆路径
        loopColor.set() // 设置颜色
        circlePath.fill() // 填充路径
        let clipPath = UIBezierPath(ovalIn: CGRect(x: borderW, y: borderW, width: size.width, height: size.height)) // 设置裁剪路径
        clipPath.addClip() // 裁剪
        draw(at: CGPoint(x: borderW, y: borderW)) // 绘制图片
        let clipImage = UIGraphicsGetImageFromCurrentImageContext() // 获取图片
        UIGraphicsEndImageContext() // 关闭上下文
        return clipImage!
    }
    
    
    class func imageWithCapture(_ oringinalView: UIView)->UIImage{
        
        UIGraphicsBeginImageContext(oringinalView.frame.size) // 开启图形上下文
        let ctx = UIGraphicsGetCurrentContext()  // 获取上下文
        oringinalView.layer.render(in: ctx!) // 渲染当前图层
        let captuerImage = UIGraphicsGetImageFromCurrentImageContext() // 从图形上下文中获取图片
        return captuerImage!
    }
    

    // MARK: 按照图片的宽高比计算图片显示的大小
    func displaySize() -> CGSize{
        // 1.拿到图片的宽高比
        let scale = self.size.height / self.size.width
        // 2.根据宽高比计算高度
        let width = kScreenWidth
        let height =  width * scale
        return CGSize(width: width, height: height)
    }

    
    // MARK: 缩放图片
    func scaleToSize(_ size: CGSize) -> UIImage{
        
        // 创建一个bitmap的context
        // 并把它设置成为当前正在使用的context
        UIGraphicsBeginImageContext(size)
        // 绘制改变大小的图片
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        // 从当前context中创建一个改变大小后的图片
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        // 使当前的context出堆栈
        UIGraphicsEndImageContext()
        // 返回新的改变大小后的图片
        return scaledImage!
    }
    
    
    // MARK: 压缩图片
    func compressImage(_ maxFileSize: Float)->UIImage{
        
        var compression: CGFloat = 0.9
        let maxCompression:CGFloat = 0.1
        var imageData = UIImageJPEGRepresentation(self, compression)
        while(Float(imageData!.count) > maxFileSize && compression > maxCompression){
            
            compression = compression - 0.1
            imageData = UIImageJPEGRepresentation(self, compression)
        }
        let compressedImage = UIImage(data: imageData!)
        return compressedImage!
    }
    
    
    // MARK: 通过颜色绘制一个UIImage
    class func imageWithColor(color: UIColor, size: CGSize)->UIImage{
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    
    
    // MARK: 添加文字水印
    func waterMarkedImage(waterMarkText:String,
                             corner:WaterMarkCorner = .BottomRight,
                             margin:CGPoint = CGPoint(x: 20, y: 20),
                             waterMarkTextColor:UIColor = UIColor.white,
                             waterMarkTextFont:UIFont = UIFont.systemFont(ofSize: 20),
                             backgroundColor:UIColor = UIColor.clear) -> UIImage{
    
    let textAttributes = [NSForegroundColorAttributeName:waterMarkTextColor,
                          NSFontAttributeName:waterMarkTextFont,
                          NSBackgroundColorAttributeName:backgroundColor]
    let textSize = NSString(string: waterMarkText).size(attributes: textAttributes)
    var textFrame = CGRect(x:0, y:0, width:textSize.width, height:textSize.height)
    
    let imageSize = self.size
        switch corner{
        case .TopLeft:
            textFrame.origin = margin
        case .TopRight:
            textFrame.origin = CGPoint(x: imageSize.width - textSize.width - margin.x, y: margin.y)
        case .BottomLeft:
            textFrame.origin = CGPoint(x: margin.x, y: imageSize.height - textSize.height - margin.y)
        case .BottomRight:
            textFrame.origin = CGPoint(x: imageSize.width - textSize.width - margin.x, y: imageSize.height - textSize.height - margin.y)
        }

        // 开始给图片添加文字水印
        UIGraphicsBeginImageContext(imageSize)
        self.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        NSString(string: waterMarkText).draw(in: textFrame, withAttributes: textAttributes)
        let waterMarkedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return waterMarkedImage!
    }
    

}
