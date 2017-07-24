//
//  seachCommonVC.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/7/4.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit

private let KSearchSourcesCellId = "KSearchSourcesCellId"

class seachCommonVC: UIViewController {

    var storys: [searchStoryModel]?{
        didSet{
            tableView.reloadData()
        }
    }

    fileprivate lazy var tableView: UITableView = {
        
        let rect = CGRect(x:0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64 - 44)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
    }
}


// MARK: 设置通知
extension seachCommonVC {
    
    func setNotice() {
        NotificationCenter.default.addObserver(self, selector: #selector(seachCommonVC.loadData(_:)), name: Notification.Name(rawValue: "loadData"), object: nil)
    }

    func loadData(_ notification: NSNotification) {
        let object = notification.object as! (generalModel, String)
        let model = object.0 as generalModel
        let searchStr = object.1 as String
        
        WLTMusicSearchTool.getSearchStoryData(1, row: model.music, search: searchStr, type: 19) { (pageModel, models, error) in
            self.storys = models
        }
    }
}


// MARK: 遵守UITableViewDelegate,UITableViewDataSource
extension seachCommonVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if storys?.count != nil {
            return (storys?.count)!
        }else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 44}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KSearchSourcesCellId ,for: indexPath) as? SearchSourcesCell
        cell?.storyModel = storys?[indexPath.row]
        return cell!
    }
}

