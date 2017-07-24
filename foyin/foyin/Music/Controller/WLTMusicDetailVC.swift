//
//  WLTMusicDetailVC.swift
//  佛音
//
//  Created by  luzhaoyang on 17/6/16.
//  Copyright © 2017年 Kingstong. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD

private let KMusicGatherCell = "KMusicGatherCell"

class WLTMusicDetailVC: UIViewController {
    
    var musicId: Int? {
        didSet{
            view.addSubview(self.tableView)
            self.setUpRefresh()
        }
    }
    
    var pageModel: PageModel = PageModel(){
        didSet{
            checkFooterState()
        }
    }
    
    var sounds: [SoundModel] = [] {
        didSet{
            tableView.reloadData()
            titleView.titleLabel.text = "共\(sounds.count)集"
            if sounds.count > 0 {
                  self.headerView.model = sounds[0]
            }
        }
    }
    
    var bottomPresentVC : WLTMusicDetailPresentView = WLTMusicDetailPresentView()
    var isPresent : Bool = false
    fileprivate lazy var headerView: WLTMusicDetailHeader = WLTMusicDetailHeader.clone()
    
    fileprivate lazy var tableView: UITableView = {
        let rect = CGRect(x:0, y:0, width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height - 64)
        let tableView = UITableView(frame: rect, style: UITableViewStyle.grouped)
        tableView.separatorStyle = .none
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.tableHeaderView = self.headerView
        tableView.register(WLTMusicGatherTableCell.self, forCellReuseIdentifier: KMusicGatherCell)
        return tableView
    }()
    
    fileprivate lazy var titleView: WLTMusicTitleView = {
        let rect = CGRect(x: 0, y: 5, width: UIScreen.main.bounds.width, height: 47)
        let titleView = WLTMusicTitleView(frame: rect, title: "", actionTitle: "")
        return titleView
    }()

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(color: APPTintColor_Brown, size: CGSize(width: 1.0,height: 1.0)), for: UIBarMetrics.default)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "佛音"
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        view.backgroundColor = UIColor.white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "szgeren"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(WLTMusicDetailVC.didClickQRCode))
    }
    
}


extension WLTMusicDetailVC {

    func didClickQRCode() {
        let LocaMianVC = WLTMusicLocaMianVC()
        navigationController?.pushViewController(LocaMianVC, animated: true)
    }
}

// MARK : 设置上下拉刷新
extension WLTMusicDetailVC {
    
    func checkFooterState() {
        tableView.mj_footer.isHidden = (sounds.count == 0)
        if sounds.count == pageModel.totalRows {
            tableView.mj_footer.endRefreshingWithNoMoreData()
        }else{
            tableView.mj_footer.endRefreshing()
        }
    }
    
    func setUpRefresh() {
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(WLTMusicDetailVC.loadNewData))
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(WLTMusicDetailVC.loadMoreData))
        tableView.mj_header.beginRefreshing()
        tableView.mj_footer.isHidden = true
    }
}


// MARK: 遵守UITableViewDelegate, UITableViewDataSource
extension WLTMusicDetailVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return self.sounds.count }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 66}
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 52 }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KMusicGatherCell ,for: indexPath) as? WLTMusicGatherTableCell
        cell?.model = sounds[indexPath.row]
        cell?.delegate = self
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            
            let hearderView = UIView()
            hearderView.backgroundColor = UIColor.white
            
            let lineView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 5))
            lineView.backgroundColor = hexColor("ebebf1")
            hearderView.addSubview(lineView)
            
            hearderView.addSubview(titleView)
            return hearderView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let model = sounds[indexPath.row]
    
        let Index = sounds.index(of: model)!
        guard  Index >= 0 else { return }
        
        let playVC = WLTMusicPlayVC()
        playVC.currentMusicCover = headerView.imageView.image
        playVC.currentMusicItemIndex = Index
        playVC.currentMusic = model
        playVC.sounds = sounds
        self.navigationController?.pushViewController(playVC, animated: true)
    }
}


// MARK: 根据Id获取集数
extension WLTMusicDetailVC {

    func loadNewData(){
    
        tableView.mj_footer.endRefreshing()
        WLTMusicListHttpTool.getMusicListById(id: musicId!, page: FromPage, row: ListRow) { (pageModel, models, error) in
            
            if(nil != error){
                SVProgressHUD.showError(withStatus: "\(error!.userInfo[NSLocalizedFailureReasonErrorKey])")
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
                return
            }
            
            self.sounds.removeAll()
            self.sounds = models
            if pageModel != nil {
                self.pageModel = pageModel!
            }
            self.tableView.mj_header.endRefreshing()
        }
    }
    
    func loadMoreData(){
        
        tableView.mj_header.endRefreshing()
        WLTMusicListHttpTool.getMusicListById(id: musicId!, page: FromPage, row: ListRow) { (pageModel, models, error) in
            
            if(nil != error){
                SVProgressHUD.showError(withStatus: "\(error!.userInfo[NSLocalizedFailureReasonErrorKey])")
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
                return
            }
            self.sounds = self.sounds + models
            if pageModel != nil{
                self.pageModel = pageModel!
            }
        }
    }

}


// MARK: 更多的界面
extension WLTMusicDetailVC: DetailCellDelegate {
    
    func clickDownload(currentModel: SoundModel) {
        showShareView(currentModel: currentModel)
    }
    
    func showShareView(currentModel: SoundModel) {
        
        // 设置转场的代理
        bottomPresentVC.modalPresentationStyle = .custom
        
        // 设置转场的代理
        bottomPresentVC.transitioningDelegate = self
        present(bottomPresentVC, animated: true, completion: nil)
        bottomPresentVC.currentMusic = currentModel
    }
}


// MAEK : 设置动画
extension WLTMusicDetailVC : UIViewControllerTransitioningDelegate {
    
    // 改变弹出vie的尺寸
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return WLTMusicDetailPresentVC(presentedViewController: presented, presenting: presenting)
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
extension WLTMusicDetailVC : UIViewControllerAnimatedTransitioning {
    
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
    private func animationForDismissedView(transitionContext: UIViewControllerContextTransitioning){
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





