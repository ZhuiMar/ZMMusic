//
//  WLTMusicHttpTool.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/6/19.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit
import Alamofire

class WLTMusicHttpTool: NSObject {

    // MARK: 获取banner数据
    class func getMusicBannerData(success:@escaping (_ models:[MusicBannerModel]) -> ()) {
        
        let url = Music_banner.completeURL
        
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                
                if let dic = value as? NSDictionary {
                                        
                    let rCode = dic["responseCode"] as! String
                    
                    if rCode == "0000" {
                    
                        let musicModels:NSMutableArray = MusicBannerModel.mj_objectArray(withKeyValuesArray: dic["data"])
                        var models = [MusicBannerModel]()
                        
                        for m in musicModels {
                            let model = m as! MusicBannerModel
                            models.append(model)
                        }

                        success(models)
                        
                    }else{
                        
                    }
                }
                
            case .failure:
                print("失败")
            }
        }
    }


    // MARK: 获取主页音乐 0:佛教音乐 3:佛教故事 5:高僧开示
    class func getMusicRecommendData(musicType: Int ,success:@escaping (_ model:[SoundModel]) -> ()) {
        
        let url = Music_recommend.completeURL + "/\(musicType)"
        
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                
                if let dic = value as? NSDictionary {
                    
                    let rCode = dic["responseCode"] as! String
                    
                    if rCode == "0000" {
                        
                        let musicModels:NSMutableArray = SoundModel.mj_objectArray(withKeyValuesArray: dic["data"])
                        var models = [SoundModel]()
                        
                        for m in musicModels {
                            let model = m as! SoundModel
                            models.append(model)
                        }
                        
                        success(models)
            
                    }else{
                        
                    }
                }
                
            case .failure:
                print("失败了")
            }
        }
    }
    
    
    // MARK: 随机获取列表 0:佛教音乐 3:佛教故事 5:高僧开示
    class func getMusicRandomData(musicType: Int ,success:@escaping (_ model:[SoundModel]) -> ()) {
        
        let url = Music_random.completeURL + "/\(musicType)"
        
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
                
            case .success(let value):
                
                if let dic = value as? NSDictionary {
                    
                    let rCode = dic["responseCode"] as! String
                    
                    if rCode == "0000" {
                        
                        let musicModels:NSMutableArray = SoundModel.mj_objectArray(withKeyValuesArray: dic["data"])
                        var models = [SoundModel]()
                        
                        for m in musicModels {
                            let model = m as! SoundModel
                            models.append(model)
                        }
                        
                        success(models)
                        
                        
                    }else{
                        
                    }
                }
                
            case .failure:
                print("失败了")
            }
        }
    }

    
}
