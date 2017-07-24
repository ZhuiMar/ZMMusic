//
//  MusicToolbar.swift
//  foyin
//
//  Created by  luzhaoyang on 17/6/21.
//  Copyright © 2017年 Kingstong. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation
import SVProgressHUD


enum PlayModel{
    
    case orderPlay  // 列表循环
    case randomPlay // 随机播放
    case circlePlay // 单曲循环
}

protocol MusicToolbarDelagate {
    
    func musicToolbarNext(_ itemIndex: Int)
    func musicToolbarPrevious(_ itemIndex: Int)
    func musicToolbarRandom(_ itemIndex: Int)
    func musicToolbarPlay(_ itemIndex: Int)
    func musicToolbarPause(_ itemIndex: Int)
    func musicToolbarDownLoad()
    func prentListView()
}

class MusicToolbar: UIView, AVAudioSessionDelegate {

    var delegate: MusicToolbarDelagate?
    var musicModels: [SoundModel] = []    // 总的音乐系列
    var currentMusicModel: SoundModel?
    var timeObserver: Any?                // 监听者
    var toggleTag: Int = 0                // 切换的标记
    var isPlay: Bool = true               // 播放状态
    var duration: Float64 = 0
    var stopValue: CGFloat = 0
    
    var playModel: PlayModel = PlayModel.orderPlay // 默认的播放的模式
    
    lazy var player: AVPlayer? = {
        
        let player = AVPlayer(playerItem: nil)
        return player
    }()

    fileprivate lazy var toggle: UIButton = {
        
        let toggle = UIButton(type: .custom)
        let image = UIImage(named: "music_Single-cycle")
        toggle.setBackgroundImage(image, for: .normal)
        toggle.addTarget(self, action: #selector(MusicToolbar.toggleActoin), for: .touchUpInside)
        return toggle
    }()
    
    fileprivate lazy var musicList: UIButton = {
        
        let musicList = UIButton(type: .custom)
        let image = UIImage(named: "menu")
        musicList.setBackgroundImage(image, for: .normal)
        musicList.addTarget(self, action: #selector(MusicToolbar.listActoin), for: .touchUpInside)
        return musicList
    }()
    
    fileprivate lazy var previous: UIButton = {
        
        let previous = UIButton(type: .custom)
        let image = UIImage(named: "music_before")
        previous.setBackgroundImage(image, for: .normal)
        previous.addTarget(self, action: #selector(MusicToolbar.previousActoin), for: .touchUpInside)
        return previous
    }()
    
    fileprivate lazy var nexts: UIButton = {
        
        let nexts = UIButton(type: .custom)
        let image = UIImage(named: "music_After")
        nexts.setBackgroundImage(image, for: .normal)
        nexts.addTarget(self, action: #selector(MusicToolbar.nextsActoin), for: .touchUpInside)
        return nexts
    }()
    
    fileprivate lazy var play: UIButton = {
        
        let play = UIButton(type: .custom)
        let image = UIImage(named: "music_pause")
        play.setBackgroundImage(image, for: .normal)
        play.addTarget(self, action: #selector(MusicToolbar.playActoin), for: .touchUpInside)
        return play
    }()

    lazy var bufferView: MyPlayProgressView = {
    
        let bufferView = MyPlayProgressView(frame: CGRect(x:45, y:90, width:UIScreen.main.bounds.width-90, height:15))
        bufferView.playProgressBackgoundColor = rgb(236, g: 9, b: 24, a: 1.0) // 划过的颜色
        bufferView.trackBackgoundColor = UIColor.gray
        bufferView.progressBackgoundColor = UIColor.lightGray
        bufferView.delegate = self
        return bufferView
    }()
    
    lazy var nowTime: UILabel = {
        
        let nowTime = UILabel()
        nowTime.textColor = UIColor.white
        nowTime.font = UIFont(name: "PingFangSC-Regular", size: 10)
        nowTime.text = "00:00"
        nowTime.textAlignment = .center
        return nowTime
    }()
    
    lazy var totalTime: UILabel = {
        
        let totalTime = UILabel()
        totalTime.textColor = UIColor.white
        totalTime.font = UIFont(name: "PingFangSC-Regular", size: 10)
        totalTime.text = "00:00"
        totalTime.textAlignment = .center
        return totalTime
    }()
    
    lazy var downLoad: UIButton = {
        
        let downLoad = UIButton(type: .custom)
        let image = UIImage(named: "music_download")
        downLoad.setBackgroundImage(image, for: .normal)
        downLoad.addTarget(self, action: #selector(MusicToolbar.downLoadActoin), for: .touchUpInside)
        return downLoad
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: 进度条的代理
extension MusicToolbar: MyPlayProgressViewDelegate {
    
    func sliderScrubbing() { // 拖动值发生改变
        
    }
    
    func beiginSliderScrubbing() { // 开始拖动
        
        guard self.player != nil else{ return }
        guard self.currentMusicModel != nil else { return }
        
        nowPause()
        isPlay = true
        stopValue = bufferView.value
    }
    
    func endSliderScrubbing() { // 结束拖动
        
        
        if self.player == nil || self.currentMusicModel == nil{
            
            bufferView.value = 0
            
        }else{
            
            let seekTime = (duration) * Float64(bufferView.value)
            
            if bufferView.trackValue < bufferView.value{
                
                bufferView.value = self.stopValue
                nowPlay()
                isPlay = false
                
            }else{
                
                player!.seek(to: CMTimeMake(Int64(seekTime), Int32(1.0))) { b in
                    self.nowPlay()
                    self.isPlay = true
                }
                
            }
        }
    }
}


// MARK: 切换播放模式
extension MusicToolbar {
    
    func toggleActoin() {
    
        toggleTag += 1
        
        if(toggleTag % 3 == 0) {
            toggle.setBackgroundImage(UIImage(named: "music_cycle"), for: .normal)
            playModel = .orderPlay
        }else if(toggleTag % 3 == 1) {
            toggle.setBackgroundImage(UIImage(named: "music_random-cycle"), for: .normal)
            playModel = .randomPlay
        }else if(toggleTag % 3 == 2) {
            toggle.setBackgroundImage(UIImage(named: "music_Single-cycle"), for: .normal)
            playModel = .circlePlay
        }else{
            assertionFailure("错误,不该有的数字")
        }
    }
}


// MARK: 上一首
extension MusicToolbar {
    
    func previousActoin() {
        playPrevious()
    }
    
    func playPrevious() {
        guard  musicModels.count != 0 else {
            SVProgressHUD.showInfo(withStatus: "播放列表为空")
            return
        }
        delegate?.musicToolbarNext(preMusicIndex())
        playMusic(preMusicModel())
    }
}


// MARK: 下一首
extension MusicToolbar {
    
    func nextsActoin() {
        playNext()
    }
    
    func playNext() {
        guard  musicModels.count != 0 else {
            SVProgressHUD.showInfo(withStatus: "播放列表为空")
            return
        }
        delegate?.musicToolbarNext(nextMusicIndex())
        playMusic(nextMusicModel())
    }
}


// MARK: 播放 & 暂停
extension MusicToolbar {
    
    func playActoin() {
        
        guard musicModels.count != 0 && currentMusicModel != nil else { return }
        
        isPlay = !isPlay
        
        switch isPlay {
        case false:
            nowPause()
            break
        case true:
            nowPlay()
            break
        }
    }
    
    // 播放
    func nowPlay()  {
        player!.play()
        delegate?.musicToolbarPlay(currentMusicIndex())
        play.setBackgroundImage(UIImage(named: "music_pause"), for: .normal)
    }
    
    // 暂停
    func nowPause() {
        player!.pause()
        delegate?.musicToolbarPause(currentMusicIndex())
        play.setBackgroundImage(UIImage(named: "music_play"), for: .normal)
    }
}


// MARK: 通过滑动切换音乐
extension MusicToolbar {

    // 开始滑动的时候暂停
    func begindScroll(){
        if isPlay == false {
            play.setBackgroundImage(UIImage(named: "music_pause"), for: .normal)
            isPlay = true
        }
    }
    
    // 停止滑动的时候播放
    func switchOver(_ currentMusicModel: SoundModel) {
        playMusic(currentMusicModel)
    }
}


// MARK: 播放音乐
extension MusicToolbar {
    
    func playMusic(_ model:SoundModel) {
    
        removePlayStatus()
        removePlayLoatTime()
        
        let url = (model.isDownLoad == true) ? URL(fileURLWithPath: model.filePath.musicDir()) : URL(string: model.filePath)!

        let playerItem = AVPlayerItem(url: url)
    
        player!.replaceCurrentItem(with: playerItem)
        
        refreshView(model) // 刷新界面UI
        setUpNotification() // 监听音乐播放完成通知
        addPlayStatus() // 监听播放器状态
        addPlayLoadTime() // 监听音乐缓冲进度
        addMusicProgress(playerItem) // 监听音乐播放的进度
        self.currentMusicModel = model // 记录当前播放音乐
    }
}


// MARK: 监听音乐的状态
extension MusicToolbar {
    
    // 通过KVO监听播放器状态
    func addPlayStatus() {
        player!.currentItem?.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    // 移除监听播放器状态
    func removePlayStatus() {
        guard currentMusicModel != nil else { return }
        player!.currentItem?.removeObserver(self, forKeyPath: "status")
    }
    
    // KVO监听音乐缓冲状态
    func addPlayLoadTime() {
        player!.currentItem?.addObserver(self, forKeyPath: "loadedTimeRanges", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    // 移除监听音乐缓冲状态
    func removePlayLoatTime() {
        guard currentMusicModel != nil else{ return }
        self.player!.currentItem?.removeObserver(self, forKeyPath: "loadedTimeRanges")
    }

    // 移除监听音乐播放进度
    func removeTimeObserver() {
        guard timeObserver != nil else{return}
        player!.removeTimeObserver(timeObserver!)
        timeObserver = nil
    }
    
    // 监听音乐播放的进度
    func addMusicProgress(_ playerItem: AVPlayerItem) {
        
        removeTimeObserver()
        timeObserver = player!.addPeriodicTimeObserver(forInterval: CMTimeMake(Int64(1.0), Int32(1.0)), queue: DispatchQueue.main) { [unowned self](time: CMTime) in
            
            // CMTimeGetSeconds函数是将CMTime转换为秒，如果CMTime无效，将返回NaN
            let currentTime = CMTimeGetSeconds(time)
            let totalTime = CMTimeGetSeconds(playerItem.asset.duration)
            
            self.bufferView.value = CGFloat(currentTime / totalTime)
            self.totalTime.text = self.convertStringWithTime(Float(totalTime))
            self.nowTime.text = self.convertStringWithTime(Float(currentTime))
            self.duration = totalTime
        }
    }
    
    // MARK: 观察者回调
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "status"{
            switch player!.status {
            case .unknown:
                print("状态未知")
            case .readyToPlay:
                print("准备播放")
            case .failed:
                print("失败")
            }
        }
        
    
        if keyPath == "loadedTimeRanges"{
            
            guard let loadedTimeRanges = player?.currentItem?.loadedTimeRanges,let first = loadedTimeRanges.first else {fatalError()}
            
            //本次缓冲时间范围
            let timeRange = first.timeRangeValue
            let startSeconds = CMTimeGetSeconds(timeRange.start) // 本次缓冲起始时间
            let durationSecound = CMTimeGetSeconds(timeRange.duration) //缓冲时间
            let result = startSeconds + durationSecound //缓冲总长度
            bufferView.trackValue = CGFloat(result / player!.currentItem!.asset.duration.seconds)
            
            
            print(CGFloat(result / player!.currentItem!.asset.duration.seconds))
            
            
            if result >= player!.currentItem!.asset.duration.seconds / 5 {
                player?.play()
            }
        }
    }

    // MARK: 停止播放
    fileprivate func stopPlay() {
    
        player!.pause()
        player!.rate = 0
        removePlayStatus()
        removePlayLoatTime()
        player!.replaceCurrentItem(with: nil)
        currentMusicModel = nil
        timeObserver = nil
    }

    // MARK: 销毁播放器
    func destroyMusicToolBar() {
        
        stopPlay()
        duration = 0
        stopValue = 0
        bufferView.value = 0
        bufferView.trackValue = 0
    }
    
    // 跟换歌曲的时候刷新界面的值
    func refreshView(_ model:SoundModel?) {
        
        bufferView.value = 0.0
        bufferView.trackValue = 0.0
        totalTime.text = "00:00"
        nowTime.text = "00:00"
    }
}



// MARK: 注册通知
extension MusicToolbar {
    
    func setUpNotification(){
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(MusicToolbar.playFinished(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player!.currentItem)
    }
    
    func playFinished(_ notifi: Notification) {
        
        switch playModel{
        case .orderPlay:
            
            playNext()

        case .randomPlay:
            
            delegate?.musicToolbarRandom(randomMusicModel().1)
            playMusic(randomMusicModel().0)
            
        case .circlePlay:
            
            playMusic(circleMusicModel())
        }
    }
}


// MARK: 下载 & 弹出列表
extension MusicToolbar {
    
    func listActoin() {
       delegate?.prentListView()
    }
    
    func downLoadActoin() {
        
        if currentMusicModel?.isDownLoad == false {
            SVProgressHUD.showSuccess(withStatus:"已添加到下载列表")
            
            let task = WLTMusicDownLoadTool.downloadMusic(currentMusicModel!)
            let taskModel = TaskModel()
            taskModel.task = task
            taskModel.musicModel = currentMusicModel
            downLoadTasks.append(taskModel)

        }else{
            SVProgressHUD.showSuccess(withStatus:"已下载")
        }
    }
}


// MARK: 创建的UI
extension MusicToolbar {
    
    func setupUI() {
        
        // 1.播放
        addSubview(play)
        play.snp.makeConstraints { (play) in
            
            play.centerX.equalTo(self.snp.centerX)
            play.bottom.equalTo(-30)
            play.width.equalTo(46)
            play.height.equalTo(46)
        }
        
        // 2.添加切换
        addSubview(toggle)
        toggle.snp.makeConstraints { (toggle) in
            
            toggle.left.equalTo(28)
            toggle.centerY.equalTo(play.snp.centerY)
            toggle.width.equalTo(30)
            toggle.height.equalTo(30)
        }
        
        // 3.添加下载
//        addSubview(musicList)
//        musicList.snp.makeConstraints { (musicList) in
//            
//            musicList.right.equalTo(-28)
//            musicList.centerY.equalTo(play.snp.centerY)
//            musicList.width.equalTo(26)
//            musicList.height.equalTo(26)
//        }
        
        // 4. 下一首
        addSubview(nexts)
        nexts.snp.makeConstraints { (nexts) in
            nexts.left.equalTo(play.snp.right).offset(44)
            nexts.centerY.equalTo(play.snp.centerY)
            nexts.width.equalTo(15)
            nexts.height.equalTo(19)
        }
        
        // 5. 上一首
        addSubview(previous)
        previous.snp.makeConstraints { (previous) in
            previous.right.equalTo(play.snp.left).offset(-44)
            previous.centerY.equalTo(play.snp.centerY)
            previous.width.equalTo(15)
            previous.height.equalTo(19)
        }
        
        // 6. 当前时间
        addSubview(nowTime)
        nowTime.snp.makeConstraints { (nowTime) in
            nowTime.left.equalTo(10)
            nowTime.width.equalTo(35)
            nowTime.top.equalTo(90)
            nowTime.height.equalTo(15)
        }
        
        // 6.1 总的时间
        addSubview(totalTime)
        totalTime.snp.makeConstraints { (totalTime) in
            
            totalTime.right.equalTo(-10)
            totalTime.centerY.equalTo(nowTime.snp.centerY)
            totalTime.height.equalTo(15)
            totalTime.width.equalTo(35)
        }
        
        // 6.2 进度条
        addSubview(bufferView)
        
        // 7.下载
        addSubview(downLoad)
        downLoad.snp.makeConstraints { (downLoad) in
            
            downLoad.right.equalTo(-28)
            downLoad.centerY.equalTo(play.snp.centerY)
            downLoad.width.equalTo(26)
            downLoad.height.equalTo(26)
        }
        
    }
}







