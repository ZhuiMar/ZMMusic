//
//  WLTMusicListHttpTool.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/6/19.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit
import Alamofire
import MJExtension

class WLTMusicListHttpTool: NSObject {

    
    // MARK: 获取推荐更多
    class func getNewBuddhistMusicData(type: Int, page:Int, row:Int, success:@escaping (_ pageModel: PageModel?, _ models:[SoundModel], _ error: NSError?) -> ()) {
        
        let url = Music_list.completeURL + "/\(type)" + "/\(page)" + "/\(row)"
        
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                
                if let dic = value as? NSDictionary {
                    
                    let responseModel = ResponseModel.mj_object(withKeyValues: dic)
                    if let resCode = ResponseCode(rawValue: (responseModel?.responseCode)!){

                        switch resCode {
                            
                        case .Success:
                            
                            let sounds: NSMutableArray = SoundModel.mj_objectArray(withKeyValuesArray: responseModel!.data?.resultData)
                        
                            var soundModels = [SoundModel]()
                            for sound in sounds {
                                soundModels.append(sound as! SoundModel)
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

    

    // MARK: 根据Id获取列表
    class func getMusicListById(id: Int, page:Int, row:Int, success:@escaping (_ pageModel: PageModel?, _ models:[SoundModel], _ error: NSError?) -> ()) {
        
        let url = Music_detailList.completeURL + "/\(id)" + "/\(page)" + "/\(row)"
        
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                
                if let dic = value as? NSDictionary {
                
                    let responseModel = ResponseModel.mj_object(withKeyValues: dic)
                    if let resCode = ResponseCode(rawValue: (responseModel?.responseCode)!){
                
                        switch resCode {
                            
                        case .Success:
                            
                            let sounds: NSMutableArray = SoundModel.mj_objectArray(withKeyValuesArray: responseModel!.data?.resultData)
                            
                            var soundModels = [SoundModel]()
                            for sound in sounds {
                                soundModels.append(sound as! SoundModel)
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

    
    
}
