//
//  WLTMusicLocalVC.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/7/6.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit
import SVProgressHUD
import MJRefresh

private let MusicLocalId = "MusicLocalId"

class WLTMusicLocalVC: UIViewController {

    fileprivate lazy var tableView: UITableView = {
        
        let rect = CGRect(x:0, y:0, width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64)
        let tableView = UITableView(frame: rect, style: UITableViewStyle.plain)
        tableView.separatorStyle = .none
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
//        tableView.tableHeaderView = self.heardView
        tableView.register(MusicLocalCell.self, forCellReuseIdentifier: MusicLocalId)
        return tableView
    }()
    
    var pageModel: PageModel = PageModel() {
        didSet{
            checkFooterState()
        }
    }
    
    var models: [SoundModel] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(color: APPTintColor_Brown, size: CGSize(width: 1.0,height: 1.0)), for: UIBarMetrics.default)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        setUpRefresh()
        setNotifice()
    }
}

// MARK: 监听删除
extension WLTMusicLocalVC {

    func setNotifice() {
        NotificationCenter.default.addObserver(self, selector: #selector(WLTMusicLocalVC.refreshUI), name: Notification.Name(rawValue: "MusicRefreshUI"), object: nil)
    }
    
    func refreshUI(){
        loadNewData()
    }
}

// MARK: 设置上下拉刷新
extension WLTMusicLocalVC {
    
    // MARK: 设置上拉下拉刷新
    func setUpRefresh(){
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(WLTMusicLocalVC.loadNewData))
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(WLTMusicLocalVC.loadMoreData))
        tableView.mj_header.beginRefreshing()
        tableView.mj_footer.isHidden = true
    }

    // MARK: 刷新头部和底部控件
    func checkFooterState() {
        
        tableView.mj_footer.isHidden = (models.count == 0)
        if models.count == pageModel.totalRows {
            tableView.mj_footer.endRefreshingWithNoMoreData()
        }else{
            tableView.mj_footer.endRefreshing()
        }
    }
}



// MARK: 加载更多
extension WLTMusicLocalVC {

    // MARK: 加载最新
    func loadNewData(){
        
        tableView.mj_footer.endRefreshing()
        SoundModel.loadCacheData(ListRow, page: FromPage) { (pageModel, models, error) -> () in
            
            if nil != error{
                SVProgressHUD.showInfo(withStatus: "暂无下载佛音")
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
                return
            }
            self.tableView.mj_header.endRefreshing()
            self.models.removeAll()
            self.models = models!
            self.pageModel = pageModel!
        }
    }
    
    
    // MARK: 加载更多
    func loadMoreData() {
        
        tableView.mj_header.endRefreshing()
        SoundModel.loadCacheData(pageModel.onePageRows, page: pageModel.currentPage+1) { (pageModel, models, error) -> () in
            
            if nil != error {
                SVProgressHUD.showError(withStatus: "您还没有下载任何数据")
                self.tableView.mj_footer.endRefreshing()
                self.tableView.mj_header.endRefreshing()
                return
            }
            self.models =  self.models + models!
            self.pageModel = pageModel!
        }
    }
}


// MARK: 遵守UITableViewDelegate,UITableViewDataSource
extension WLTMusicLocalVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return models.count }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 60}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MusicLocalId ,for: indexPath) as? MusicLocalCell
        cell?.model = models[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.row]
        let Index = models.index(of: model)!
        guard  Index >= 0 else { return }
        let playVC = WLTMusicPlayVC()
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: model.fileCover))
        playVC.currentMusicCover = imageView.image
        playVC.currentMusicItemIndex = Index
        playVC.currentMusic = model
        playVC.sounds = models
        self.navigationController?.pushViewController(playVC, animated: true)
    }
}




