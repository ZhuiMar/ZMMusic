//
//  WLTMusicDownVC.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/7/10.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit
import Alamofire

private let MusicDownCellId = "MusicDownCell"

private var mycontext = 0

class WLTMusicDownVC: UIViewController {
    
    fileprivate lazy var tableView: UITableView = {
        
        let rect = CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 108)
        let tableView = UITableView(frame: rect, style: UITableViewStyle.plain)
        tableView.separatorStyle = .none
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.register(MusicDownCell.self, forCellReuseIdentifier: MusicDownCellId)
        return tableView
    }()
    
    var models: [TaskModel] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        models = downLoadTasks
       // setNotion()
    }
}



// MARk: 下载完成之后删除下载任务
extension WLTMusicDownVC {

    func setNotion() {
         NotificationCenter.default.addObserver(self, selector: #selector(WLTMusicDownVC.refreshUI), name: NSNotification.Name(rawValue: "musicDownLoadSuusceRefreshUI"), object: nil)
    }
    
    func refreshUI() {
       models = downLoadTasks
    }
}




// MARK: 遵守UITableViewDelegate,UITableViewDataSource
extension WLTMusicDownVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return models.count }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 60}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MusicDownCellId ,for: indexPath) as? MusicDownCell
        cell?.model = models[indexPath.row]
        return cell!
    }
}


