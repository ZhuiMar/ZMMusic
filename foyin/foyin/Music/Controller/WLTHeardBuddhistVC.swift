//
//  WLTHeardBuddhistVC.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/6/13.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD

private let KWLTBuddhistCell = "KWLTBuddhistCell"

class WLTHeardBuddhistVC: UIViewController {
    
    var type :Int? {
        didSet {
            view.addSubview(tableView)
            setUpRefresh()
        }
    }
    
    var pageModel: PageModel = PageModel(){
        didSet{
            checkFooterState()
        }
    }
    
    var sounds: [SoundModel] = [] {
        didSet{
            tableView.reloadData()
        }
    }

    fileprivate lazy var tableView: UITableView = {
        
        let rect = CGRect(x:0, y:0, width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height - 64)
        let tableView = UITableView(frame: rect, style: UITableViewStyle.plain)
        tableView.separatorStyle = .none
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WLTBuddhistTableViewCell.self, forCellReuseIdentifier: KWLTBuddhistCell)
        return tableView
    }()

    override func viewDidLoad() {
         super.viewDidLoad()
         automaticallyAdjustsScrollViewInsets = false
         view.addSubview(tableView)
    }
}


// MARK : 设置上下拉刷新
extension WLTHeardBuddhistVC {
    
    func checkFooterState() {
        self.tableView.mj_footer.isHidden = (sounds.count == 0)
        if sounds.count == pageModel.totalRows {
            tableView.mj_footer.endRefreshingWithNoMoreData()
        }else{
            tableView.mj_footer.endRefreshing()
        }
    }
    
    func setUpRefresh() {
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(WLTBuddhistMusicVC.loadNewData))
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(WLTBuddhistMusicVC.loadMoreData))
        tableView.mj_header.beginRefreshing()
        tableView.mj_footer.isHidden = true
    }
}


// 加载数据
extension WLTHeardBuddhistVC {
    
    func loadNewData() {
        
        tableView.mj_footer.endRefreshing()
        WLTMusicListHttpTool.getNewBuddhistMusicData(type: type!, page: FromPage, row: ListRow) { (pageModel, models, error) in
            
            if(nil != error) {
                SVProgressHUD.showError(withStatus: "\(error!.userInfo[NSLocalizedFailureReasonErrorKey])")
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
                return
            }
            self.sounds.removeAll()
            self.sounds = models
            if pageModel != nil{
                self.pageModel = pageModel!
            }
            self.tableView.mj_header.endRefreshing()
        }
    }
    
    func loadMoreData() {
        
        tableView.mj_header.endRefreshing()
        WLTMusicListHttpTool.getNewBuddhistMusicData(type: type!, page: pageModel.currentPage+1, row: pageModel.onePageRows) { (pageModel, models, error) in
            if(nil != error){
                SVProgressHUD.showError(withStatus: "\(error!.userInfo[NSLocalizedFailureReasonErrorKey])")
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
                return
            }
            self.sounds = self.sounds + models
            if pageModel != nil{
                self.pageModel = pageModel!
            }
        }
    }
}


extension WLTHeardBuddhistVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return self.sounds.count }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 100 }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = WLTBuddhistTableViewCell(style:UITableViewCellStyle.default, reuseIdentifier: KWLTBuddhistCell)
        cell.tag = indexPath.row
        cell.model = self.sounds[indexPath.row]
        cell.delegate = self
        return cell
    }
}


extension WLTHeardBuddhistVC: WLTBuddhistTableViewCellDelegate {
    
    func clickCell(_ tag: Int) {
        let model = sounds[tag]
        let musicDetailVC = WLTMusicDetailVC()
        musicDetailVC.musicId = model.id
        self.navigationController?.pushViewController(musicDetailVC, animated: true)
    }
}



