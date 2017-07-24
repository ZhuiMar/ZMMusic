//
//  NetworkTools.swift
//  Buddha
//
//  Created by 龙钒 on 2017/5/4.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools {
    
    class func requestData(type: MethodType, URLString: String, parameters: [String : Any]? = nil, finishedCallBack : @escaping (_ result : Any) -> ())  {
        //1.获取类型
        let method = type == .get ? HTTPMethod.post : HTTPMethod.post
        //2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters,encoding: JSONEncoding.default).responseJSON { (response) in
            //3.获取结果
            guard let result = response.result.value else {
//                print(response.result.error as Any)
                return
            }
            //4.回调
            finishedCallBack(result)
        }
    }
    
    
}
