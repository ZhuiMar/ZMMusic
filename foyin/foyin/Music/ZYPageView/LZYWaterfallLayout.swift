//
//  LZYWaterfallLayout.swift
//  swift3.0-瀑布流
//
//  Created by  luzhaoyang on 17/6/12.
//  Copyright © 2017年 Kingstong. All rights reserved.
//

import UIKit


protocol LZYWaterfallLayoutDelegate : class {
    func waterfallLayout(_layout:LZYWaterfallLayout, itemIndex: Int) ->CGFloat
}

class LZYWaterfallLayout: UICollectionViewFlowLayout {
    var cols :Int = 0  // 列数
    weak var dataSource : LZYWaterfallLayoutDelegate?
    lazy var attributes : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var maxHeight : CGFloat = self.sectionInset.top + self.sectionInset.bottom
    fileprivate lazy var heights:[CGFloat] = Array(repeating: self.sectionInset.top, count: self.cols)
}

// MARK : 准备所有的cell的布局
extension LZYWaterfallLayout {

    override func prepare() {
        
        // CellFrame -> UICollectionViewLayoutAttributes
        // 1.获取一组里面的cell的个数
        guard let collectionView = collectionView  else { return }
        let counts = collectionView.numberOfItems(inSection: 0)
        
        // 3.给每一个Attributes天加一frame
        let itemW = (collectionView.bounds.width - sectionInset.right - sectionInset.left - (CGFloat(cols - 1) * minimumLineSpacing)) / CGFloat(cols)
        
        for i in attributes.count..<counts {
            
            let indexPath = IndexPath(item: i, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 方法1
//            guard let itemH = dataSource?.waterfallLayout(_layout: self, itemIndex: i) else {
//                fatalError("请先设置数据源,再用waterfallLayout")
//            }
            
            // 方法2
            let itemH = dataSource?.waterfallLayout(_layout: self, itemIndex: i) ?? 100 // ??表示 dataSource这个可选类型为空的话直接去100
            
            let minH = heights.min()!
            let minIndex = heights.index(of: minH)!
            
            let itemX = sectionInset.left + (minimumLineSpacing + itemW) * CGFloat(minIndex)
            let itemY = minH
            attribute.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
            
            // 3.1添加属性到数组中
            self.attributes.append(attribute)
            
            // 3.2改变minIndex位置的高度
            heights[minIndex] = attribute.frame.maxY + minimumLineSpacing
        }
    
        // 4.获取最大的高度
        maxHeight = heights.max()! - minimumLineSpacing
    }
}


// MARK : 告诉系统准备好的布局
extension LZYWaterfallLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
}

// MARK : 告诉系统滚动范围
extension LZYWaterfallLayout {
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: maxHeight + sectionInset.bottom)
    }
}
