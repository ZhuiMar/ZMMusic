//
//  searchMusicVC.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/7/4.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD


private let KSearchSourcesCellId = "KSearchSourcesCellId"

class searchMusicVC: UIViewController {

    var musics: [SearchMusicModel]? {
        
        didSet{
            tableView.reloadData()
        }
    }
    
    var currentImage: UIImage = UIImage()
    
    fileprivate lazy var tableView: UITableView = {
        
        let rect = CGRect(x:0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64 - 44)
        let tableView = UITableView(frame: rect, style: UITableViewStyle.plain)
        tableView.separatorStyle = .none
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.register(SearchSourcesCell.self, forCellReuseIdentifier: KSearchSourcesCellId)
        return tableView
    }()
    
    init?(type: Int){
        super.init(nibName: nil, bundle: nil)
        setNotice()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(color: APPTintColor_Brown, size: CGSize(width: 1.0,height: 1.0)), for: UIBarMetrics.default)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
    }
}


// MARK: 设置通知
extension searchMusicVC {
    
    func setNotice() {
        NotificationCenter.default.addObserver(self, selector: #selector(searchMusicVC.loadData(_:)), name: Notification.Name(rawValue: "loadData"), object: nil)
    }

    func loadData(_ notification: NSNotification) {
        
        let object = notification.object as! (generalModel, String)
        let model = object.0 as generalModel
        let searchStr = object.1 as String
        
        WLTMusicSearchTool.getSearchMusicData(1, row: model.music, search: searchStr, type: 1) { (pageModel, models, error) in
            self.musics = models
        }
    }
}



// MARK: 遵守UITableViewDelegate,UITableViewDataSource
extension searchMusicVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if musics?.count != nil {
            return (musics?.count)!
        }else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 44}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KSearchSourcesCellId ,for: indexPath) as? SearchSourcesCell
        cell?.musicModel = musics?[indexPath.row]
        currentImage = cell!.sourcesImage.image!
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let model = musics?[indexPath.row]
        let detailVC = WLTMusicDetailVC()
        detailVC.musicId = model?.buddhistMusicId
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

