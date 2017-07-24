//
//  NSFileManager+Extend.swift
//  Buddha
//
//  Created by 魏翔 on 16/11/24.
//  Copyright © 2016年 魏翔. All rights reserved.
//

import Foundation

extension FileManager{
    
    class func folderWith(_ folderPath: String)->Bool{
        
        let fileManager = FileManager.default
        
        //判断文件夹是否存在，不存在则创建
        let exist = fileManager.fileExists(atPath: folderPath)
        
        if !exist{
            do{
                try fileManager.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
            }catch{
                
                return false
            }
            
        }
        
        return true
        
    }
    
}
