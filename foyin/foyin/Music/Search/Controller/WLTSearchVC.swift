//
//  WLTSearchVC.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/7/4.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit

class WLTSearchVC: UIViewController, UISearchBarDelegate, UISearchResultsUpdating {

    fileprivate var currentPage: Int!
//    fileprivate var []: [generalModel, String]!
    
    lazy var searchController: UISearchController = {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        return searchController
    }()
    
    init?(currentPage: Int){
        self.currentPage = currentPage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearcnBar()
        setChildVC()
    }
}


// MARK: 创建子控制器
extension WLTSearchVC {

    func setChildVC(){
        
        automaticallyAdjustsScrollViewInsets = false
    
        let pageFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        let tittles = ["全部","佛经","佛音", "佛教故事", "佛教常识"]
        var childVcs = [UIViewController]()
        var style = ZYPageStyle()
        style.isScrollEnable = false
        style.isNeedScale = false
        style.isShowCoverView = true
        style.isShowBottomLine = false
        
        let allVC = searchAllVC()
        let bookVC = searchBookVC(type: 0)
        let musicVC = searchMusicVC(type: 0)
        let storyVC = searchStoryVC(type: 0)
        let commonVC = seachCommonVC(type: 0)
        
        childVcs.append(allVC)
        childVcs.append(bookVC!)
        childVcs.append(musicVC!)
        childVcs.append(storyVC!)
        childVcs.append(commonVC!)
        
        let pageView  =  ZYPageView(frame: pageFrame, tittles: tittles, style: style, childVcs: childVcs, parentVc: self, currentPage: currentPage)
        self.view.addSubview(pageView)
    }
}


// MARK: 设置UI
extension WLTSearchVC {
    
    func setUpSearcnBar() {
        
        let searchBar = searchController.searchBar
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.barTintColor = APPTintColor_Brown
        setUpPlaceholder(searchBar)
        navigationItem.titleView = searchBar
        definesPresentationContext = true
    }
    
    func setUpPlaceholder(_ searchBar: UISearchBar) {
        let placeholder = "搜索"
        let attributedString = NSMutableAttributedString(string: placeholder)
        let searchTextField = searchBar.value(forKey: "searchField") as? UITextField
        searchTextField?.attributedPlaceholder = attributedString
        
        if #available(iOS 9.0, *) {
            self.searchController.loadViewIfNeeded()
        } else {
            
        }
    }
    
    // 搜索按钮点击事件
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchContentForText((self.searchController.searchBar.text)!)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print("jhkahkdhk")
    }
    
    // 搜索数据请求
    func searchContentForText(_ searchText: String) {
        
        WLTMusicSearchTool.getSearchGeneralData(searchText) { (model) in
            NotificationCenter.default.post(name: Notification.Name(rawValue: "loadData"), object: (model,searchText))
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        if self.searchController.isActive{
            self.searchController.isActive = false
            self.searchController.searchBar.removeFromSuperview()
        }
    }
}
