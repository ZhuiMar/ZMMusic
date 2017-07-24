//
//  WLTMainMusicVC.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/6/13.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit

private let KWLTBuddhistCell = "KWLTBuddhistCell"

class WLTMainMusicVC: UIViewController {

    fileprivate lazy var headerView: WLTMainMusicHeaderView = WLTMainMusicHeaderView.clone()
    fileprivate lazy var footerView: WLTMainMusicFooterView = WLTMainMusicFooterView.clone()
    fileprivate lazy var selectorView: MusicSelectView = MusicSelectView.clone()
    
    fileprivate lazy var tableView: UITableView = {
        
        let rect = CGRect(x:0, y:34, width:kScreenWidth, height: kScreenHeight - 64 - 34)
        let tableView = UITableView(frame: rect, style: UITableViewStyle.grouped)
        tableView.separatorStyle = .none
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.tableHeaderView = self.headerView
        tableView.tableFooterView = self.footerView
        self.headerView.delegate = self
        self.footerView.delegate = self
        tableView.register(WLTBuddhistTableViewCell.self, forCellReuseIdentifier: KWLTBuddhistCell)
        return tableView
    }()
    
    fileprivate lazy var searchBarView: WLTSearchView = {
    
        let rect = CGRect(x: 0, y: 0, width: 316, height: 30)
        let searchBarView = WLTSearchView(frame: rect)
        searchBarView.layer.cornerRadius = 5
        searchBarView.layer.masksToBounds = true
        searchBarView.backgroundColor = UIColor.white
        return searchBarView
    }()
    
    fileprivate lazy var changeView: WLTMusicChangeView = {
        
        let rect = CGRect(x: (kScreenWidth - 60)/2, y: (52-5-12)/2, width: 60, height: 12)
        let changeView = WLTMusicChangeView(frame: rect, style: musicType.headerBuddhist)
        changeView.delegate = self
        return changeView
    }()

    var hearDataArr:[SoundModel]? {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        getdata()
        getrandomData()
        setUpSearcnBar()
    }
}


// MARK: 设置UI
extension WLTMainMusicVC {
    
     func setUI(){
    
        // 1.设置选择条的父视图
        view.addSubview(selectorView)
        selectorView.delegate = self
    
        // 2.添加tabView
        view.addSubview(tableView)
    }
}


// MARK: 设置UI
extension WLTMainMusicVC {
    
    func setUpSearcnBar() {

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "geren"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(WLTMainMusicVC.didClickQRCode))
        navigationItem.titleView = self.searchBarView
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTap))
        self.searchBarView.addGestureRecognizer(tap)
    }
    
    func viewTap() {
        
        let VC = WLTSearchVC(currentPage: 0)
        navigationController?.pushViewController(VC!, animated: true)
    }
    
    func didClickQRCode() {
        let LocaMianVC = WLTMusicLocaMianVC()
        navigationController?.pushViewController(LocaMianVC, animated: true)
    }
}



// MARK: 获取数据
extension WLTMainMusicVC {
   
    // 获取听闻佛事
    fileprivate func getdata() {
        WLTMusicHttpTool.getMusicRecommendData(musicType: 3) { (models) in
            self.hearDataArr = models
        }
    }
    
   // 随机获取听闻佛事
   fileprivate func getrandomData() {
    
        changeView.revealPlay()
        WLTMusicHttpTool.getMusicRandomData(musicType: 5) { (models) in
            self.hearDataArr = models
            self.changeView.revealStop()
        }
   }
}


// MARK: 遵守UITableViewDelegate,UITableViewDataSource
extension WLTMainMusicVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 3 }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 100}
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 52 }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { return 52 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KWLTBuddhistCell ,for: indexPath) as! WLTBuddhistTableViewCell
        if hearDataArr?.count == 6 { cell.model = hearDataArr?[indexPath.row] }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let hearderView = UIView()
            hearderView.backgroundColor = UIColor.white
        
            let lineView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 5))
            lineView.backgroundColor = hexColor("ebebf1")
            hearderView.addSubview(lineView)
            
            let rect = CGRect(x: 0, y: 5, width: kScreenWidth, height: 47)
            let titleView = WLTMusicTitleView(frame: rect, title: musicType.headerBuddhist.rawValue, actionTitle: "更多")
            titleView.delegate = self
            hearderView.addSubview(titleView)
            return hearderView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 0 {
            let footerView = UIView()
            footerView.backgroundColor = UIColor.white
            
            let lineView = UIView(frame: CGRect(x: 0, y: 52-5, width: kScreenWidth, height: 5))
            lineView.backgroundColor = hexColor("ebebf1")
            footerView.addSubview(lineView)
            
            footerView.addSubview(changeView)
            return footerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         tableView.deselectRow(at: indexPath, animated: true)
         let model = hearDataArr?[indexPath.row]
         let musicDetailVC = WLTMusicDetailVC()
         musicDetailVC.musicId = model?.id
         self.navigationController?.pushViewController(musicDetailVC, animated: true)
    }
}


// MARK: 顶部的跳转
extension WLTMainMusicVC: MusicSelectViewDelegate {
    
    func jumpToNextVC(selectView: MusicSelectView, tag: Int) {
        let VC = WLTMainMusicListVC(currentPage: tag)
        self.navigationController?.pushViewController(VC!, animated: false)
    }
}


// MARK: 换一批
extension WLTMainMusicVC: WLTMusicChangeViewDelagate {
    
    func changeView(_ changeView: WLTMusicChangeView, style: musicType) {
        if style == musicType.headerBuddhist {
            getrandomData()
        }
    }
}


// MARK: 更多推荐
extension WLTMainMusicVC: HeaderViewDelegate {
    
    func buddhistMoreJump(_ tag: Int) {
        let VC = WLTMainMusicListVC(currentPage: tag)
        self.navigationController?.pushViewController(VC!, animated: false)
    }
    
    func buddhistDetialJump(_ musicModel: SoundModel) {
        let musicDetailVC = WLTMusicDetailVC()
        musicDetailVC.musicId = musicModel.id
        self.navigationController?.pushViewController(musicDetailVC, animated: true)
    }
    
    func bannerJumpToNext(_ model: MusicBannerModel) {
        
        let musicDetailVC = WLTMusicDetailVC()
        musicDetailVC.musicId = model.contentId
        self.navigationController?.pushViewController(musicDetailVC, animated: true)
    }
}


// MARK: 更多听闻佛事
extension WLTMainMusicVC: WLTMusicTitleViewDelegate {
    
    func musicTitleView(_ musicTitleView: WLTMusicTitleView, title: String) {
        if title == "听闻佛事" {
            let VC = WLTMainMusicListVC(currentPage: 1)
            self.navigationController?.pushViewController(VC!, animated: false)
        }
    }
}


// MARK: 更多智慧开示
extension WLTMainMusicVC: FooterVieDelegate {
    
    func wisdomRevealMore(_ tag: Int) {
        let VC = WLTMainMusicListVC(currentPage: tag)
        self.navigationController?.pushViewController(VC!, animated: false)
    }
    
    func wisdomRevealDetail(_ musicModel: SoundModel) {
        let musicDetailVC = WLTMusicDetailVC()
        musicDetailVC.musicId = musicModel.id
        self.navigationController?.pushViewController(musicDetailVC, animated: true)
    }
}





