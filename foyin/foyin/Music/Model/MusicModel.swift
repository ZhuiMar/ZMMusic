//
//  MusicModel.swift
//  Buddha
//
//  Created by 魏翔 on 16/8/28.
//  Copyright © 2016年 魏翔. All rights reserved.
//

import UIKit
import Alamofire



enum MusicType: Int{
    
    case songSheet = 4 //歌单
    case recommend = 0 //其他
    case incantation = 1 //咒语
    case sutra = 2 //佛经
    case music = 3 //佛乐
}


class MusicModel: NSObject {
    
    // 每个字段的含义
    var resId: String!                    // 音乐的Id
    var musicName: String!                // 音乐的名称
    var downloadNo: String!               // 下载数量
    var fileAuthor: String!               // 音乐的作者
    var musicCover: String!               // 音乐的封面
    var musicDescription: String!         // 音乐的具体的描述
    var musicPath : String!               // 音乐的播放路径
    var musicType: String!                // 音乐的类型 1:咒语 2:佛经 3:佛乐
    var playTag: NSInteger!               
    
    var musicFloatSize:Float = 0.0
    
    // 计算属性
    var musicSize: String! {              // 音乐的大小
        set{
            let musicSizeStr: NSString = newValue as NSString
            self.musicFloatSize = musicSizeStr.floatValue / 1024
        }
    
        get{
             let strForMusicSize = String(format: "%.2f", musicFloatSize)
             return strForMusicSize
        }
    }
    
    /** 辅助属性 */
    var isDownLoad: Bool = false           // 音乐是否被下载了
    var downLoadProgress: CGFloat = 0
    var sortNo: Int = 0
    
}


extension MusicModel {
    

}
