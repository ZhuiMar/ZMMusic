//
//  SoundModel.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/6/19.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit

class SoundModel: NSObject {
    
    var buddhistMusicId: Int = 0
    var collectionNum:Int = 0
    var createTime: Int = 0
    var enable: Int = 1
    var fileCover:String = ""
    var fileDesc = ""
    var filePath = ""
    var fileSize: Float = 0.0
    var fileTitle = ""
    var heatRange: Int = 0
    var id: Int = 0
    var likeNum: Int = 0
    var shareNum: Int = 0
    var updateTime: Int = 0
    var fileType: Int = 0
    var version: Int = 0
    var scanNum: Int = 0
    
    // 是否被下载了
    var isDownLoad: Bool = false
    var downLoadProgress: CGFloat = 0
    
//    var musicFloatSize:Float = 0.0
//    
//    // 计算属性
//    var musicSize: String! { // 音乐的大小
//        set{
//            let musicSizeStr: NSString = newValue as NSString
//            self.fileSize = musicSizeStr.floatValue / 1024
//        }
//        
//        get{
//            let strForMusicSize = String(format: "%.2f", musicFloatSize)
//            return strForMusicSize
//        }
//    }
    
}




extension SoundModel {
    
    // 从数据库里面读数据
    class func loadCacheData(_ row: Int, page: Int, finished: ((_ pageModel: PageModel?,_ models: [SoundModel]?,_ error: NSError?)->())) {
        
        let musicDao = MusicDao()
        
        musicDao.music(with: page, row) { (pageModel, models, error) in
            return finished(pageModel,models,error)
        }
    }
}
