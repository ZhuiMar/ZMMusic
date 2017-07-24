//
//  WLTMusicPlayVC.swift
//  佛音
//
//  Created by  luzhaoyang on 17/6/16.
//  Copyright © 2017年 Kingstong. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

private let KDiscCell = "KDiscCell"

class WLTMusicPlayVC: UIViewController {
    
    fileprivate let transform: CATransform3D = CATransform3DIdentity
    
    var playListView : WLTPlayPresentVC = WLTPlayPresentVC()
    var isPresent : Bool = false
    var currentMusicCover: UIImage?
    var currentMusicItemIndex: Int?
    var currentMusic: SoundModel?
    
    var sounds: [SoundModel] = [] {
        didSet{
            addTurnAnimation(baseCover)
            layoutUI()
        }
    }
    
    fileprivate lazy var collectionView : UICollectionView = {
        
        let layout = ZYPageCollectionViewLayout()
        layout.sectionInSet = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemMargin = 0
        layout.lineMargin = 0
        layout.cols = 1
        layout.rows = 1
        let rect = CGRect(x: 0, y: 0, width: 0, height: 0)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(WLTMusicDiscCell.self, forCellWithReuseIdentifier: KDiscCell)
        return collectionView
    }()
    
    fileprivate lazy var musiToolBar : MusicToolbar = {
        
        let musiToolBar = MusicToolbar()
        musiToolBar.backgroundColor = UIColor.clear
        musiToolBar.delegate = self
        return musiToolBar
    }()
    
    fileprivate lazy var handleBase: UIImageView = {
        
        let handleBase = UIImageView()
        handleBase.image = UIImage(named: "handlebase")
        return handleBase
    }()
    
    fileprivate lazy var handle: UIImageView = {
        
        let handle = UIImageView()
        handle.image = UIImage(named: "handle")
        handle.layer.anchorPoint = CGPoint(x: 0.06521739, y: 0.04181185)
        return handle
    }()
    
    fileprivate lazy var base: UIView = {
        
        let rect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
        let base = UIView(frame: rect)
        base.backgroundColor = UIColor.clear
        return base
    }()
    
    fileprivate lazy var baseCover: UIImageView = {
        
        let baseCover = UIImageView()
        baseCover.layer.cornerRadius = 95.5
        baseCover.layer.masksToBounds = true
        baseCover.image = self.currentMusicCover
        return baseCover
    }()
    
    fileprivate lazy var halo: UIImageView = {
        
        let halo = UIImageView()
        halo.image = UIImage(named: "halo")
        halo.backgroundColor = UIColor.clear
        return halo
    }()
    
    fileprivate lazy var blurImageView: UIImageView = {
        
        let w = self.view.frame.width
        let h = self.view.frame.height
        let rect = CGRect(x: 0, y: 0, width: w, height: h)
        let blurImageView = UIImageView(frame: rect)
        blurImageView.contentMode = .scaleAspectFill
        return blurImageView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationItem.title = currentMusic?.fileTitle
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "share"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(WLTMusicPlayVC.didClickRightItem))
        blurImageView.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        blurImageView.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        musiToolBar.destroyMusicToolBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        musiToolBar.musicModels = sounds
        musiToolBar.playMusic(currentMusic!)
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            self.collectionView.scrollToItem(at: IndexPath(item: self.currentMusicItemIndex!, section: 0), at: .left, animated: false)
        }
    }
}


// MARK:
extension WLTMusicPlayVC {

    func prepareUI() {
    
        if self.currentMusicCover == nil {
            self.currentMusicCover = UIImage(named: "remedial")
        }
        
        self.frostBackground(img: self.currentMusicCover!, view: self.view)
        self.handle.layer.transform = CATransform3DRotate(self.transform, CGFloat(-M_PI_4), 0, 0, 1)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.handleDown(0.5)
        }
    }
}


// MARK: 创建毛玻璃效果的背景
extension WLTMusicPlayVC {
    
    func frostBackground (img: UIImage, view: UIView) {
        
        blurImageView.image = img
        
        // 创建毛玻璃效果层
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark)) as UIVisualEffectView
        visualEffectView.frame = blurImageView.frame
        
        // 添加毛玻璃效果层
        blurImageView.addSubview(visualEffectView)
        self.view.insertSubview(blurImageView, belowSubview: view)
    }
}


// MARK: 切换的碟
extension WLTMusicPlayVC: UICollectionViewDelegate, UICollectionViewDataSource,UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sounds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KDiscCell, for: indexPath) as! WLTMusicDiscCell
        if baseCover.isHidden == false {
            cell.cover.isHidden = true
        }else {
            cell.cover.isHidden = false
        }
        return cell
    }
    
    // 将要拽动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        baseCover.isHidden = true
        collectionView.reloadData()
        revealStop(baseCover)
        baseCover.layer.removeAllAnimations()
        handleUp(0.5)
        musiToolBar.begindScroll()
    }
    
    // 减速
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        baseCover.isHidden = false
        let offset = scrollView.contentOffset.x
        currentMusicItemIndex = Int(offset/UIScreen.main.bounds.width)
        collectionView.reloadData()
        addTurnAnimation(baseCover)
        revealPlay(baseCover)
        
        // 当前的title
        currentMusic = currentSound(currentMusicItemIndex!)
        navigationItem.title = currentMusic?.fileTitle
        
        // 播放
        musiToolBar.switchOver(currentMusic!)
        
        // 把手
        handleDown(0.5)
    }
    
    // MARK: 获取当前的model
    fileprivate func currentSound(_ currentIndex: Int) -> SoundModel {
        
        var index = currentIndex
        if index >= sounds.count {
            index = 0
        }else {
            index = currentMusicItemIndex!
        }
        let model = sounds[index]
        return model
    }
}


extension WLTMusicPlayVC: MusicToolbarDelagate {
    
    func musicToolbarRandom(_ itemIndex: Int) {
        
        // 随机数大于当前下标  左滚
        if itemIndex > currentMusicItemIndex! {
            rollLeft(0.5, handleAnimateTime: 0.5, atItem: itemIndex)
        }
        // 随机数小于当前下标 右滚
        if itemIndex < currentMusicItemIndex! {
            rollRight(0.5, handleAnimateTime: 0.5, atItem: itemIndex)
        }
        
        // 更新当前下标
        currentMusicItemIndex = itemIndex
    }
    
    func musicToolbarPrevious(_ itemIndex: Int) {
        
         currentMusicItemIndex = itemIndex
         baseCover.isHidden = true
         revealStop(baseCover)
         baseCover.layer.removeAllAnimations()
         rollRight(0.5, handleAnimateTime: 0.3, atItem: itemIndex)
         collectionView.reloadData()
         currentMusic = currentSound(currentMusicItemIndex!)
         navigationItem.title = currentMusic?.fileTitle
    }
    
    func musicToolbarNext(_ itemIndex: Int) {
        
         currentMusicItemIndex = itemIndex
         baseCover.isHidden = true
         revealStop(baseCover)
         baseCover.layer.removeAllAnimations()
         rollLeft(0.5, handleAnimateTime: 0.5, atItem: itemIndex)
         collectionView.reloadData()
         currentMusic = currentSound(currentMusicItemIndex!)
         navigationItem.title = currentMusic?.fileTitle
    }
    
    func musicToolbarPause(_ itemIndex: Int) {
        
        revealStop(baseCover)
        handleUp(0.5)
        collectionView.reloadData()
    }
    
    func musicToolbarPlay(_ itemIndex: Int) {
        
        revealPlay(baseCover)
        handleDown(0.5)
        collectionView.reloadData()
    }
    
    func prentListView() {
        
        playListView.modalPresentationStyle = .custom
        playListView.transitioningDelegate = self
        present(playListView, animated: true, completion: nil)
        playListView.models = sounds
    }
    
    func musicToolbarDownLoad() {
        
        print("下载")
    }
}


// MARK: 分享
extension WLTMusicPlayVC {

    func didClickRightItem() {
        WLTShareMusicTool.musicShare(currentMusic!)
    }
}


// MARK: handle & collection 起来和落下的动画
extension WLTMusicPlayVC {
    
    fileprivate func handleUp(_ animateTimer: CGFloat) {
        UIView.animate(withDuration: TimeInterval(animateTimer)) {
            self.handle.layer.transform = CATransform3DRotate(self.transform, CGFloat(-M_PI_4), 0, 0, 1)
        }
    }
    
    fileprivate func handleDown(_ animateTimer: CGFloat) {
        UIView.animate(withDuration: TimeInterval(animateTimer)) {
            self.handle.layer.transform = CATransform3DRotate(self.transform, CGFloat(0), 0, 0, 1)
        }
    }
    
    fileprivate func rollLeft(_ rollAnimateTime: CGFloat, handleAnimateTime: CGFloat ,atItem: Int) {

        UIView.animate(withDuration: TimeInterval(rollAnimateTime), animations: {
             self.handle.layer.transform = CATransform3DRotate(self.transform, CGFloat(-M_PI_4), 0, 0, 1)
             self.collectionView.scrollToItem(at: IndexPath(item: atItem, section: 0), at: .left, animated: false )
        }) { (true) in
            
            self.baseCover.isHidden = false
            self.addTurnAnimation(self.baseCover)
            self.revealPlay(self.baseCover)
            self.collectionView.reloadData()
            self.handleDown(handleAnimateTime)
        }
    }
    
    fileprivate func rollRight(_ rollAnimateTime: CGFloat, handleAnimateTime: CGFloat ,atItem: Int) {
    
        UIView.animate(withDuration: TimeInterval(rollAnimateTime), animations: {
            
           self.handle.layer.transform = CATransform3DRotate(self.transform, CGFloat(-M_PI_4), 0, 0, 1)
           self.collectionView.scrollToItem(at: IndexPath(item: atItem, section: 0), at: .right, animated: false)
            
        }) { (true) in
            
            self.baseCover.isHidden = false
            self.addTurnAnimation(self.baseCover)
            self.revealPlay(self.baseCover)
            self.collectionView.reloadData()
            self.handleDown(handleAnimateTime)
        }
    }
}


extension  WLTMusicPlayVC {
    
    func addTurnAnimation(_ imageView: UIImageView) -> () {
        imageView.layer.removeAnimation(forKey: "foreImageViewRotationAnimation")
        let anaimation = CABasicAnimation(keyPath: "transform.rotation.z")
        anaimation.fromValue = 0
        anaimation.toValue = M_PI * 2
        anaimation.duration = 20
        anaimation.repeatCount = MAXFLOAT
        anaimation.isRemovedOnCompletion = false // 退出界面要不要停止动画
        imageView.layer.add(anaimation, forKey: "foreImageViewRotationAnimation")
    }
    func revealPlay(_ imageView: UIImageView) {
        imageView.layer.resumeAnimation()
    }
    func revealStop(_ imageView: UIImageView) {
        imageView.layer.pauseAnimation()
    }
}


// MARK: 布局UI
extension WLTMusicPlayVC {
    
    func layoutUI() {
        
        // 1.添加转盘的背景
        self.view.addSubview(base)
        base.snp.makeConstraints { (base) in
            
            base.top.equalTo(70 + 64)
            base.left.equalTo(0)
            base.right.equalTo(0)
            base.height.equalTo(310)
        }
        
        // 1.1 添加光晕
        base.addSubview(halo)
        halo.snp.makeConstraints { (halo) in
            
            halo.width.equalTo(310)
            halo.centerX.equalTo(base.snp.centerX)
            halo.centerY.equalTo(base.snp.centerY)
        }
        
        base.addSubview(baseCover)
        baseCover.snp.makeConstraints { (baseCover) in
            
            baseCover.center.equalTo(base.snp.center)
            baseCover.width.equalTo(191)
            baseCover.height.equalTo(191)
        }
        
        // 2.添加collectionView
        base.addSubview(collectionView)
        collectionView.snp.makeConstraints { (collectionView) in
            
            collectionView.top.equalTo(0)
            collectionView.left.equalTo(0)
            collectionView.right.equalTo(0)
            collectionView.bottom.equalTo(0)
        }
        
        // 设置把手的基座
        self.view.addSubview(handleBase)
        handleBase.snp.makeConstraints { (handleBase) in
            
            handleBase.centerX.equalTo(self.view.snp.centerX)
            handleBase.top.equalTo(64)
            handleBase.width.equalTo(32)
            handleBase.height.equalTo(22)
        }
        
        // 3.设置把手
        self.view.addSubview(handle)
        handle.snp.makeConstraints { (handle) in
            
            handle.centerX.equalTo(self.view.snp.centerX).offset(0.17)
            handle.top.equalTo(-2)
            handle.width.equalTo(92)
            handle.height.equalTo(143.5)
        }
        
        // 4.添加音乐的安钮
        self.view.addSubview(musiToolBar)
        musiToolBar.snp.makeConstraints { (musiToolBar) in
            
            musiToolBar.left.equalTo(0)
            musiToolBar.right.equalTo(0)
            musiToolBar.bottom.equalTo(0)
            musiToolBar.height.equalTo(200)
        }
        
    }
}


// MAEK : 设置动画
extension WLTMusicPlayVC : UIViewControllerTransitioningDelegate {
    
    // 改变弹出vie的尺寸
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return WLTMusicePresentVC(presentedViewController: presented, presenting: presenting)
    }
    // 自定义弹出的动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        return self
    }
    // 自定义消失的动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        return self
    }
}


// MAEK : 自定义弹出和消失的动画
extension WLTMusicPlayVC : UIViewControllerAnimatedTransitioning {
    
    // 动画执行的时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    // 获取专场的上下文(通过上下文获取弹出的view和消失的view)
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresent ? animationForPresentedView(transitionContext: transitionContext) : animationForDismissedView(transitionContext: transitionContext)
    }
    
    // 弹出
    private func animationForPresentedView(transitionContext: UIViewControllerContextTransitioning) {
        // 1.获取弹出的view
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        // 2.将弹出的View添加到container中
        transitionContext.containerView.addSubview(presentedView!)
        // 3.执行动画
        presentedView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
        // 4.设置锚点就是动画从哪个地方出现
        presentedView?.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        // 5.开始动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            presentedView?.transform = CGAffineTransform.identity
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    
    // 消失
    private func animationForDismissedView(transitionContext: UIViewControllerContextTransitioning) {
        // 拿到消失的View
        let dismissedView = transitionContext.view(forKey:  UITransitionContextViewKey.from)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            dismissedView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.0001)
        }) { (_) in
            dismissedView?.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}







