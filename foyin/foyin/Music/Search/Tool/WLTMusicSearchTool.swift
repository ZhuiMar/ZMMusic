//
//  WLTMusicSearchTool.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/7/4.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit
import Alamofire

class WLTMusicSearchTool: NSObject {

    // 佛音
    class func getSearchMusicData(_ page: Int, row: Int, search: String, type: Int, success:@escaping (_ pageModel: PageModel?, _ models:[SearchMusicModel], _ error: NSError?) -> ())  {
        
        let url = Music_search.completeURL
        
        Alamofire.request(url, method: .post, parameters: ["page": page, "row": row , "search":search, "type":type], encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                
                if let dic = value as? NSDictionary {
                    
                    let responseModel = ResponseModel.mj_object(withKeyValues: dic)
                    if let resCode = ResponseCode(rawValue: (responseModel?.responseCode)!){
                        
                        switch resCode {
                            
                        case .Success:
                            
                            let sounds: NSMutableArray = SearchMusicModel.mj_objectArray(withKeyValuesArray: responseModel!.data?.resultData)
                            var soundModels = [SearchMusicModel]()
                            for sound in sounds {
                                soundModels.append(sound as! SearchMusicModel)
                            }
                            let pageModel = responseModel?.data?.pageModel
                            success(pageModel,soundModels,nil)

                            
                        case .Failure:
                            let error = NSError(domain: ErrorDomain, code: Int(resCode.rawValue)!, userInfo: [ErrorKey: resCode.responseMsg()])
                            print(error)
                        case .SystemError:
                            let error = NSError(domain: ErrorDomain, code: Int(resCode.rawValue)!, userInfo: [ErrorKey: resCode.responseMsg()])
                            print(error)
                        }
                    }
                }
                
            case .failure:
                let error = NSError(domain: ErrorDomain, code: ErrorCode, userInfo: [ErrorKey: ErrorMsg])
                print(error)
            }
        }
    }
    
    

    // 佛经
    class func getSearchBookData(_ page: Int, row: Int, search: String, type: Int, success:@escaping (_ pageModel: PageModel?, _ models:[BookItemModel], _ error: NSError?) -> ())  {
        
        let url = Music_search.completeURL
        
        Alamofire.request(url, method: .post, parameters: ["page": page, "row": row , "search":search, "type":type], encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                
                if let dic = value as? NSDictionary {
                    
                    let responseModel = ResponseModel.mj_object(withKeyValues: dic)
                    if let resCode = ResponseCode(rawValue: (responseModel?.responseCode)!){
                        
                        switch resCode {
                            
                        case .Success:
                            
                            let books: NSMutableArray = BookItemModel.mj_objectArray(withKeyValuesArray: responseModel!.data?.resultData)
                            var bookModels = [BookItemModel]()
                            for book in books {
                                bookModels.append(book as! BookItemModel)
                            }
                            let pageModel = responseModel?.data?.pageModel
                            success(pageModel,bookModels,nil)
                            
                            
                        case .Failure:
                            let error = NSError(domain: ErrorDomain, code: Int(resCode.rawValue)!, userInfo: [ErrorKey: resCode.responseMsg()])
                            print(error)
                        case .SystemError:
                            let error = NSError(domain: ErrorDomain, code: Int(resCode.rawValue)!, userInfo: [ErrorKey: resCode.responseMsg()])
                            print(error)
                        }
                    }
                }
                
            case .failure:
                let error = NSError(domain: ErrorDomain, code: ErrorCode, userInfo: [ErrorKey: ErrorMsg])
                print(error)
            }
        }
    }

    // 佛教故事
    class func getSearchStoryData(_ page: Int, row: Int, search: String, type: Int, success:@escaping (_ pageModel: PageModel?, _ models:[searchStoryModel], _ error: NSError?) -> ())  {
        
        let url = Music_search.completeURL
        
        Alamofire.request(url, method: .post, parameters: ["page": page, "row": row , "search":search, "type":type], encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                
                if let dic = value as? NSDictionary {
                    
                    let responseModel = ResponseModel.mj_object(withKeyValues: dic)
                    if let resCode = ResponseCode(rawValue: (responseModel?.responseCode)!){
                        
                        switch resCode {
                            
                        case .Success:
                            
                            let storys: NSMutableArray = searchStoryModel.mj_objectArray(withKeyValuesArray: responseModel!.data?.resultData)
                            var storyModels = [searchStoryModel]()
                            for story in storys {
                                storyModels.append(story as! searchStoryModel)
                            }
                            let pageModel = responseModel?.data?.pageModel
                            success(pageModel,storyModels,nil)
                            
                            
                        case .Failure:
                            let error = NSError(domain: ErrorDomain, code: Int(resCode.rawValue)!, userInfo: [ErrorKey: resCode.responseMsg()])
                            print(error)
                        case .SystemError:
                            let error = NSError(domain: ErrorDomain, code: Int(resCode.rawValue)!, userInfo: [ErrorKey: resCode.responseMsg()])
                            print(error)
                        }
                    }
                }
                
            case .failure:
                let error = NSError(domain: ErrorDomain, code: ErrorCode, userInfo: [ErrorKey: ErrorMsg])
                print(error)
            }
        }
    }
    
    
    

    // 总的搜索
    class func getSearchGeneralData(_ search: String, success: @escaping (_ model: generalModel) -> Void){
    
        let urlStr = Music_search_general.completeURL + "/\(search)" as NSString
        let url = urlStr.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(url!, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                
                if let dic = value as? NSDictionary {
                    
                    let responseModel = ResponseModel.mj_object(withKeyValues: dic)
                    if let resCode = ResponseCode(rawValue: (responseModel?.responseCode)!){
                        
                        switch resCode {
                            
                        case .Success:
                            
                            let model = generalModel.mj_object(withKeyValues: dic["data"])
                            success(model!)

                        case .Failure:
                            let error = NSError(domain: ErrorDomain, code: Int(resCode.rawValue)!, userInfo: [ErrorKey: resCode.responseMsg()])
                            print(error)
                        case .SystemError:
                            let error = NSError(domain: ErrorDomain, code: Int(resCode.rawValue)!, userInfo: [ErrorKey: resCode.responseMsg()])
                            print(error)
                        }
                    }
                }
                
            case .failure:
                let error = NSError(domain: ErrorDomain, code: ErrorCode, userInfo: [ErrorKey: ErrorMsg])
                print(error)
            }
        }
    }
    
    
    
    
    

}
