//
//  searchAllVC.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/7/4.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit

private let KSearchAllCellId = "KSearchAllCellId"

class searchAllVC: UIViewController {

    var generalModel: generalModel? {

        didSet{
            
           let book = setStringColor("\((generalModel?.book)!)" , totalStr:"已搜索到【佛经】相应结果")
           let music = setStringColor("\((generalModel?.music)!)", totalStr:"已搜索到【佛音】相应结果")
           let story = setStringColor("\((generalModel?.story)!)", totalStr:"已搜索到【佛教故事】相应结果")
           let commonSense = setStringColor("\((generalModel?.story)!)", totalStr:"已搜索到【佛教常识】相应结果")
            
           generals.append(book)
           generals.append(music)
           generals.append(story)
           generals.append(commonSense)
            
            if generals.count == 4 {
                tableView.reloadData()
            }
        }
    }
    
    var generals:[NSMutableAttributedString] = [NSMutableAttributedString]()
    
    fileprivate lazy var tableView: UITableView = {
        
        let rect = CGRect(x:0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let tableView = UITableView(frame: rect, style: UITableViewStyle.plain)
        tableView.separatorStyle = .none
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.register(SearchAllCell.self, forCellReuseIdentifier: KSearchAllCellId)
        return tableView
    }()
    
    func setStringColor(_ subStr: String, totalStr: String) -> NSMutableAttributedString {
        
        let subStrLenght = (subStr as NSString).length
        let totalStrLenght = (totalStr as NSString).length
        let location = totalStrLenght
        let attribute = NSMutableAttributedString(string: totalStr + subStr + "条")
        let range = NSMakeRange(location, subStrLenght)
        let color = hexColor("baa674")
        attribute.addAttribute(NSForegroundColorAttributeName, value:color, range:range)
        return attribute
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        setNotice()
    }
}

// MARK: 设置通知
extension searchAllVC {
    
    func setNotice() {
        NotificationCenter.default.addObserver(self, selector: #selector(searchAllVC.loadData(_:)), name: Notification.Name(rawValue: "loadData"), object: nil)
    }
    
    func loadData(_ notification: NSNotification) {
        let object = notification.object as! (generalModel, String)
        generalModel = object.0
    }
}

// MARK: 遵守UITableViewDelegate,UITableViewDataSource
extension searchAllVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return generals.count }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 44}

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KSearchAllCellId ,for: indexPath) as! SearchAllCell
        cell.article = self.generals[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let index = indexPath.row
        NotificationCenter.default.post(name: Notification.Name(rawValue: "pageViewRoll"), object: index + 1)
    }
}

