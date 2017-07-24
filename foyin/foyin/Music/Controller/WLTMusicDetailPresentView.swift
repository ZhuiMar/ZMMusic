//
//  WLTMusicDetailPresentView.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/7/11.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit
import SVProgressHUD

private let MusicDetailActionCellId = "MusicDetailActionCellId"

class WLTMusicDetailPresentView: UIViewController {

    var currentMusic: SoundModel?
   
    fileprivate lazy var tableView: UITableView = {
        
        let rect = CGRect(x:0, y:0, width:kScreenWidth, height: 121)
        let tableView = UITableView(frame: rect, style: UITableViewStyle.plain)
        tableView.separatorStyle = .none
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.register(MusicDetailActionCell.self, forCellReuseIdentifier: MusicDetailActionCellId)
        return tableView
    }()
    
    fileprivate lazy var icons:[String] = ["handle_forward","xiazai_new"]
    fileprivate lazy var titles:[String] = ["分享","下载"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
    }
}


// MARK: 遵守UITableViewDelegate,UITableViewDataSource

extension WLTMusicDetailPresentView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return titles.count }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 60 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: MusicDetailActionCellId ,for: indexPath) as? MusicDetailActionCell
        if cell == nil {
            cell = MusicDetailActionCell(style: .default, reuseIdentifier: MusicDetailActionCellId)
        }
        
        cell?.icon = icons[indexPath.row]
        cell?.title = titles[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    
        if indexPath.row == 0 { // 分享
            
            WLTShareMusicTool.musicShare(currentMusic!)
            
        }else { // 下载
            
            if currentMusic?.isDownLoad == false {
                
                SVProgressHUD.showSuccess(withStatus:"已添加到下载列表")
                let task = WLTMusicDownLoadTool.downloadMusic(currentMusic!)
                let taskModel = TaskModel()
                taskModel.task = task
                taskModel.musicModel = currentMusic
                downLoadTasks.append(taskModel)
                
            }else{
                 SVProgressHUD.showSuccess(withStatus:"已下载")
            }
        }
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "WLTMusicePresentVCClose"), object: nil)
    }
}

