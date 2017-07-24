
//
//  APPDefine.swift
//  WXYourSister
//
//  Created by 魏翔 on 16/6/21.
//  Copyright © 2016年 魏翔. All rights reserved.
//

import Foundation
import UIKit

// MARK: 公用
let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height
let APP_Mac_Key = UIDevice.current.identifierForVendor!.uuidString
let kStatusBarH: CGFloat = 20
let kNavigationBarH: CGFloat = 44
let kTabBarH: CGFloat = 44

// MARK: 七牛云存储域名
let QiniuDomain = "https://obzuhugxn.qnssl.com/"
let APP_Token = "token"
let UserInfoFilePath = "UserInfo.archive".docDir()   //
let WX_APPID = "wxb50a7017793466f2"
let APP_IconUrl = "https://oi7xpaxoj.qnssl.com/image57.png"

// MARK: 颜色
let APPTintColor_Blue = hexColor("7bffff")
let APPTintColor_Gold = hexColor("d9b765")
let APPTintColor_Gray = hexColor("eaeaea")
let APPTintColor_Brown = hexColor("baa674")
let APPTabBar_Color = hexColor("ffffff")
let APPNavBar_Color = hexColor("532f1f")
let Separatorline_Color = UIColor(red: 52/255.0, green: 53/255.0, blue: 61/255.0, alpha: 0.3)


let ShareSDKAPPKey: String = "186073000fda9"                    // shareSDK -16b050fa77800
let APPYMDFormatterStr = "yyyy-MM-dd"                           // 时间formatter
let StudyWordsFont: CGFloat = 17                                // 研习简介字体大小
let SectionBookNum: Int = 3                                     // 研习书架每行书的数量
let CollectionBook: String = "CollectionBook"                   // 常量key，用于在userDefault中找书架中的书籍
let ReadedBook: String = "readedBook"                           //userDefault中读过的书的缓存key
let VideoRecord : String = "VideoRecord"

let FromPage:Int = 1                                            // 第几页
let ListRow: Int = 15                                           // 每页行数

let WordComment: String = "0"                                   // 文字评论
let AudioComment: String = "1"                                  // 语音评论

// MARK: 请求出错
let ErrorKey = "errorMsg"
let ErrorMsg = "网络超时，请下拉重新加载数据"
let ErrorCode:Int = 3333
let ErrorDomain = "wlt.buddha.error"

let water = "?imageMogr2/blur/1x0/quality/75|watermark/1/image/aHR0cHM6Ly9vYnp1aHVneG4ucW5zc2wuY29tLyVFNSVCRSVBRSVFNCVCRiVBMSVFNSU5QiVCRSVFNyU4OSU4N18yMDE3MDYyNzE4MTUwOS5wbmc=/dissolve/100/gravity/NorthEast/dx/10/dy/10|imageslim"

let companyUrl = "http://www.muyusay.com"






