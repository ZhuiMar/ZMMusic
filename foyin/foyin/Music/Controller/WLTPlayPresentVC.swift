//
//  WLTPlayPresentVC.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/7/6.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit
import SnapKit

private let KMusicListCellId = "KMusicListCellId"

class WLTPlayPresentVC: UIViewController {

    fileprivate lazy var tableView: UITableView = {
        
        let rect = CGRect(x:0, y:51, width:UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*2/3 - 102)
        let tableView = UITableView(frame: rect, style: UITableViewStyle.plain)
        tableView.separatorStyle = .none
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.register(MusicListCell.self, forCellReuseIdentifier: KMusicListCellId)
        return tableView
    }()

    fileprivate lazy var barLineView: UIView = {
        let barLineView = UIView()
        barLineView.backgroundColor = rgb(235, g: 235, b: 241, a: 1.0)
        return barLineView
    }()
    
    fileprivate lazy var buttonLineView: UIView = {
        let buttonLineView = UIView()
        buttonLineView.backgroundColor = rgb(235, g: 235, b: 241, a: 1.0)
        return buttonLineView
    }()
    
    fileprivate lazy var barView: UIView = {
        let barView = UIView()
        return barView
    }()
    
    fileprivate lazy var closeButton: UIButton = {
    
        let closeButton = UIButton(type: .custom)
        closeButton.addTarget(self, action: #selector(WLTPlayPresentVC.closeAction), for: .touchUpInside)
        closeButton.setTitle("关闭", for: .normal)
        closeButton.setTitleColor(hexColor("333333"), for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return closeButton
    }()
    
    var models: [SoundModel] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupUI()
    }
}


// MARK: 布局UI

extension WLTPlayPresentVC {

    fileprivate func setupUI() {
    
        self.view.addSubview(closeButton)
        closeButton.snp.makeConstraints { (closeButton) in
            
            closeButton.left.equalTo(0)
            closeButton.right.equalTo(0)
            closeButton.bottom.equalTo(0)
            closeButton.height.equalTo(50)
        }
        
        self.view.addSubview(buttonLineView)
        buttonLineView.snp.makeConstraints { (buttonLineView) in
            
            buttonLineView.left.equalTo(0)
            buttonLineView.right.equalTo(0)
            buttonLineView.bottom.equalTo(closeButton.snp.top)
            buttonLineView.height.equalTo(0.5)
        }
        
        self.view.addSubview(barLineView)
        barLineView.snp.makeConstraints { (barLineView) in
            
            barLineView.top.equalTo(50)
            barLineView.left.equalTo(0)
            barLineView.right.equalTo(0)
            barLineView.height.equalTo(0.5)
        }
        
        self.view.addSubview(tableView)
    }
}


extension WLTPlayPresentVC {
    
    func closeAction() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "WLTMusicePresentVCClose"), object: nil)
    }
}


// MARK: 遵守UITableViewDelegate,UITableViewDataSource
extension WLTPlayPresentVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return models.count }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 46}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: KMusicListCellId ,for: indexPath) as? MusicListCell
        if cell == nil {
            cell = MusicListCell(style: .default, reuseIdentifier: KMusicListCellId)
        }
        
        cell?.model = models[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    
        
        
        
    }
    
}







