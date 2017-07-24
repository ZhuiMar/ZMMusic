//
//  NetWorkTool.swift
//  Buddha
//
//  Created by 魏翔 on 16/11/21.
//  Copyright © 2016年 魏翔. All rights reserved.
//

import UIKit

import Alamofire

class NetWorkTool: SessionManager{

    static let tools:NetWorkTool = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20 //请求时长
        let tool = NetWorkTool(configuration: config)
        return tool
    }()
    
    // 获取单粒的方法
    class func shareNetworkTools() -> NetWorkTool {
        return tools
    }
}
