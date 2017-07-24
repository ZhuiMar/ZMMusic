//
//  WLTMusicDownLoadTool.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/7/10.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

enum AudioType: String{
    
    case Music = "Music"
}

var downLoadTasks: [TaskModel] = [] // 下载任务的列表

class WLTMusicDownLoadTool: NSObject {
    
    // MARK: 下载任务
    class func downloadMusic(_ model: SoundModel) -> DownloadRequest {
        
        // 下载的文件保存的路径
        let destination: DownloadRequest.DownloadFileDestination = { temporaryURL, response in
            
            let directoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            let folder = directoryURL.appendingPathComponent("\(AudioType.Music.rawValue)", isDirectory: true)
            let _ = FileManager.folderWith(folder.path)
            let pathComponent = response.suggestedFilename!
            let musicPath = folder.appendingPathComponent(pathComponent)
            model.filePath = pathComponent
            return (musicPath, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        // 下载任务
        let task: DownloadRequest = Alamofire.download(model.filePath, to: destination).responseData { response in
                
                switch response.result {
                    
                case .success:
        
                    model.isDownLoad = true
                    let musicDao = MusicDao()
                    musicDao.addMusic(music: model)
                
                case .failure:

                    print("下载失败")
                }
        }
        
        return task
    }
}
