//
//  ResponseModel.swift
//  Buddha
//
//  Created by Apple on 16/9/14.
//  Copyright © 2016年 魏翔. All rights reserved.
//

import UIKit
enum ResponseCode: String{
    
    case Success = "0000"
    
    case Failure = "1111"
    
    case SystemError = "2222"
    
    func responseMsg() -> String{
        switch self {
            case .Success:
                return "操作成功"
            case .Failure:
                return "操作失败"
            
            case .SystemError:
                return "系统异常"
        }
    }
}

class ResponseModel: NSObject {

    var data: DataModel?
    
    var responseCode: String!
    
    var responseMessage: String!
    
}

class ResponseObjectModel: NSObject {
    var data: [String : AnyObject]!
    
    var responseCode: String!
    
    var responseMessage: String!
}
