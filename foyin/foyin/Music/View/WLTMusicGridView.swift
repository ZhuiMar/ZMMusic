//
//  WLTMusicGridView.swift
//  佛音
//
//  Created by  luzhaoyang on 17/6/15.
//  Copyright © 2017年 Kingstong. All rights reserved.
//


import UIKit
private let KCellKey = "KCellKey"

protocol WLTMusicGridViewDelegate {

    func musicGridView(_ musicGrid: WLTMusicGridView, musicModel: SoundModel)
}

let Kwidth = UIScreen.main.bounds.size.width

class WLTMusicGridView: UIView {
    
    var delegate: WLTMusicGridViewDelegate?
    fileprivate var actionTitle: String!
    fileprivate var title: String!
    fileprivate var type: Int!
    fileprivate var items: Int = 6
    
    fileprivate lazy var layout: ZYPageCollectionViewLayout = {
        
        let layout = ZYPageCollectionViewLayout()
        layout.sectionInSet = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.itemMargin = 6
        layout.lineMargin = 10
        layout.cols = 3
        layout.rows = 2
        return layout
    }()
    
    var recommendDataArr:[SoundModel]? {
        didSet{
            collectionView.reloadData()
        }
    }
    
    var wisdomDataArr:[SoundModel]? {
        didSet{
            collectionView.reloadData()
        }
    }
    
    lazy var titleLabelView: WLTMusicTitleView = {
        let titleLabelView = WLTMusicTitleView(frame: CGRect(x: 0, y: 0, width: Kwidth, height: 47), title: self.title, actionTitle: self.actionTitle!)
        return titleLabelView
    }()
    
    fileprivate lazy var collectionView : UICollectionView = {
        
        let rect = CGRect(x: 0, y: self.titleLabelView.frame.maxY, width: self.bounds.width, height: 323 + 25)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: self.layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(WLTMusicCollectionCell.self, forCellWithReuseIdentifier: KCellKey)
        return collectionView
    }()

    init(frame: CGRect, title: String, actionTitle: String, type: Int) {
        self.actionTitle = actionTitle
        self.title = title
        self.type = type
        super.init(frame: frame)
        setupUi() // 法师
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension WLTMusicGridView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KCellKey, for: indexPath) as! WLTMusicCollectionCell
        
        switch self.type {
        case 0:
            
            if recommendDataArr?.count == items {
                cell.model = recommendDataArr?[indexPath.row]
            }
            
            break
        case 5:
            
            if wisdomDataArr?.count == items {
                cell.model = wisdomDataArr?[indexPath.row]
            }
            
            break
        default:
            break
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch self.type {
        case 0:
            
            guard let m = self.recommendDataArr?[indexPath.item] else { return }
            delegate?.musicGridView(self, musicModel: (m))
    
            break
            
        case 5:
            
            guard let model = self.wisdomDataArr?[indexPath.item] else { return }
            delegate?.musicGridView(self, musicModel: (model))
            
            break
        default:
            break
        }
    }
    
}


// MARK: 设置Ui
extension WLTMusicGridView {

    fileprivate func setupUi() {
    
        // 1.创建标题栏
        addSubview(self.titleLabelView)
        
        // 2.创建九宫格
        addSubview(self.collectionView)
    }
}
