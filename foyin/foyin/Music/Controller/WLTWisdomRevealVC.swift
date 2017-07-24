//
//  WLTWisdomRevealVC.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/6/13.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD

private let KCellKey = "KCellKey"

class WLTWisdomRevealVC: UIViewController {
    
    var type :Int? {
        didSet {
            self.view.addSubview(self.collectionView)
            setUpRefresh()
        }
    }
    
    var pageModel: PageModel = PageModel() {
        didSet{
            checkFooterState()
        }
    }
    
    var sounds: [SoundModel] = [] {
        didSet{
            collectionView.reloadData()
        }
    }
    
    fileprivate lazy var layout: LZYWaterfallLayout = {
        
        let layout = LZYWaterfallLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 18.5
        layout.dataSource = self
        layout.cols = 3
        return layout
    }()

    fileprivate lazy var collectionView : UICollectionView = {
        
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height - 64)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: self.layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(WLTMusicCollectionCell.self, forCellWithReuseIdentifier: KCellKey)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
    }
}


// MARK : 设置上下拉刷新
extension WLTWisdomRevealVC {
    
    func checkFooterState() {
        self.collectionView.mj_footer.isHidden = (sounds.count == 0)
        if sounds.count == pageModel.totalRows {
            collectionView.mj_footer.endRefreshingWithNoMoreData()
        }else{
            collectionView.mj_footer.endRefreshing()
        }
    }
    
    func setUpRefresh(){
        
        loadNewData()
        collectionView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(WLTBuddhistMusicVC.loadMoreData))
        collectionView.mj_footer.isHidden = true
    }
}




// 加载数据
extension WLTWisdomRevealVC {
    
    func loadNewData() {
        
        WLTMusicListHttpTool.getNewBuddhistMusicData(type: type!, page: FromPage, row: ListRow) { (pageModel, models, error) in
            
            if(nil != error){
                SVProgressHUD.showError(withStatus: "\(error!.userInfo[NSLocalizedFailureReasonErrorKey])")
                self.collectionView.mj_header.endRefreshing()
                self.collectionView.mj_footer.endRefreshing()
                return
            }
            self.sounds.removeAll()
            self.sounds = models
            if pageModel != nil{
                self.pageModel = pageModel!
            }
        }
    }
    
    func loadMoreData() {
        
        WLTMusicListHttpTool.getNewBuddhistMusicData(type: type!, page: pageModel.currentPage+1, row: pageModel.onePageRows) { (pageModel, models, error) in
            if(nil != error){
                SVProgressHUD.showError(withStatus: "\(error!.userInfo[NSLocalizedFailureReasonErrorKey])")
                self.collectionView.mj_header.endRefreshing()
                self.collectionView.mj_footer.endRefreshing()
                return
            }
            self.sounds = self.sounds + models
            if pageModel != nil{
                self.pageModel = pageModel!
            }
        }
    }
}



extension WLTWisdomRevealVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sounds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KCellKey, for: indexPath) as! WLTMusicCollectionCell
        cell.model = self.sounds[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.sounds[indexPath.item]
        let musicDetailVC = WLTMusicDetailVC()
        musicDetailVC.musicId = model.id
        self.navigationController?.pushViewController(musicDetailVC, animated: true)
    }
}

extension WLTWisdomRevealVC: LZYWaterfallLayoutDelegate {
    
    func waterfallLayout(_layout: LZYWaterfallLayout, itemIndex: Int) -> CGFloat {
        return 150
    }
}

