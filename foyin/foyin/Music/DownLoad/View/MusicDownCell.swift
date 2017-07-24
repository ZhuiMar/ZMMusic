//
//  MusicDownCell.swift
//  Buddha
//
//  Created by  luzhaoyang on 17/7/10.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher


protocol MusicDownCellDelegate {
    
}

class MusicDownCell: UITableViewCell {
    
    var cancelledData: Data? // 意外终止的时候储存数据
    
    var tasks: NSMutableArray = NSMutableArray()
    
    var model: TaskModel? {
    
        didSet{
        
            // 1.从数组中取出下载的任务,设置cell的进度
            let task = model?.task
            self.task = task
            tasks.add(task!)
            
            // 2.取出音乐的信息设置图片的和标题
            guard let musicModel: SoundModel = model?.musicModel else { return }
            self.music = musicModel
        }
    }
    
    var task: DownloadRequest? {
    
        didSet{
            
            if CGFloat((task?.progress.completedUnitCount)!)/CGFloat((task?.progress.totalUnitCount)!) == 1 {
                
                progrossView.progress = 1
                
            }else{
                task?.downloadProgress(closure: { (progress) in
                    self.progrossView.progress = Float(CGFloat(CGFloat(progress.completedUnitCount)/CGFloat(progress.totalUnitCount)))
                
                    let fileSize = String(format: "%.2f", (self.music?.fileSize)!/1024/1024)
                    let prossesSize = String(format: "%.2f", ( (self.music?.fileSize)!/1024/1024 * self.progrossView.progress))
                    self.sizeLabel.text = prossesSize + "/" + fileSize + "M"
                })
            }
            
            task?.responseData(completionHandler: {  response in
                
                switch response.result {
                    
                case .success:
                
                    self.stopOrLoadButton.isEnabled = false
                    self.stopOrLoadButton.setTitle("完成", for: .normal)
                    
                case .failure:
                    self.cancelledData = response.resumeData
                }
            })
        }
    }
    
    var music: SoundModel? {
    
        didSet{
            
            coverImage.kf.setImage(with:  URL(string: (music?.fileCover)!))
            
//            coverImage.sd_setImage(with: URL(string: (music?.fileCover)!),placeholderImage: UIImage(named: "loading_cover"))
            
            titlelabel.text = music?.fileTitle
            
        }
    }
    
    fileprivate lazy var coverImage: UIImageView = {
        
        let coverImage = UIImageView()
        coverImage.layer.shadowOpacity = 0.5
        coverImage.layer.shadowColor = UIColor.black.cgColor
        coverImage.layer.shadowOffset = CGSize(width: 1, height: 1)
        return coverImage
    }()
    
    fileprivate lazy var stopOrLoadButton: UIButton = {
    
        let stopOrLoadButton = UIButton(type: .custom)
        stopOrLoadButton.setTitle("暂停", for: .normal)
        stopOrLoadButton.backgroundColor = APPTintColor_Brown
        stopOrLoadButton.setTitleColor(hexColor("333333"), for: .normal)
        stopOrLoadButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        stopOrLoadButton.addTarget(self, action: #selector(MusicDownCell.stopOrLoadAction(_:)), for: .touchUpInside)
        stopOrLoadButton.layer.cornerRadius = 3
        stopOrLoadButton.layer.masksToBounds = true
        return stopOrLoadButton
    }()
    
    fileprivate lazy var titlelabel: UILabel = {
        
        let titlelabel = UILabel()
        titlelabel.textColor = hexColor("333333")
        titlelabel.font = UIFont.systemFont(ofSize: 14)
        return titlelabel
    }()
    
    fileprivate lazy var progrossView: UIProgressView = {
        let progrossView = UIProgressView(progressViewStyle: .default)
        progrossView.progressTintColor = rgb(236, g: 9, b: 24, a: 1.0)//已有进度颜色
        progrossView.trackTintColor = UIColor.lightGray//剩余进度颜色
        progrossView.layer.cornerRadius = 1
        progrossView.layer.masksToBounds = true
        return progrossView
    }()
    
    fileprivate lazy var sizeLabel: UILabel = {
        
        let sizeLabel = UILabel()
        sizeLabel.textColor = hexColor("333333")
        sizeLabel.font = UIFont.systemFont(ofSize: 10)
        return sizeLabel
    }()
    
    fileprivate lazy var lineView: UIView = {
        
        let lineView = UIView()
        lineView.backgroundColor = rgb(235, g: 235, b: 241, a: 1.0)
        return lineView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension MusicDownCell {

    fileprivate func setupUI() {
    
        addSubview(coverImage)
        coverImage.snp.makeConstraints { (coverImage) in
            
            coverImage.top.equalTo(10)
            coverImage.left.equalTo(15)
            coverImage.width.equalTo(40)
            coverImage.height.equalTo(40)
        }
        
        addSubview(stopOrLoadButton)
        stopOrLoadButton.snp.makeConstraints { (stopOrLoadButton) in
            
            stopOrLoadButton.centerY.equalTo(self.snp.centerY)
            stopOrLoadButton.right.equalTo(-15)
            stopOrLoadButton.height.equalTo(30)
            stopOrLoadButton.width.equalTo(50)
        }
        
        addSubview(titlelabel)
        titlelabel.snp.makeConstraints { (titlelabel) in
            
            titlelabel.left.equalTo(coverImage.snp.right).offset(15)
            titlelabel.height.equalTo(15)
            titlelabel.top.equalTo(10)
            titlelabel.right.equalTo(stopOrLoadButton.snp.left).offset(-20)
        }
        
        addSubview(progrossView)
        progrossView.snp.makeConstraints { (progrossView) in
            
            progrossView.left.equalTo(coverImage.snp.right).offset(15)
            progrossView.top.equalTo(titlelabel.snp.bottom).offset(13)
            progrossView.width.equalTo(150)
            progrossView.height.equalTo(2)
            
        }
        
        addSubview(sizeLabel)
        sizeLabel.snp.makeConstraints { (sizeLabel) in
            
            sizeLabel.centerY.equalTo(progrossView.snp.centerY)
            sizeLabel.left.equalTo(progrossView.snp.right).offset(5)
            sizeLabel.height.equalTo(13)
            sizeLabel.right.equalTo(stopOrLoadButton.snp.left)
        }
        
        addSubview(lineView)
        lineView.snp.makeConstraints { (lineView) in
            
            lineView.left.right.equalTo(60)
            lineView.right.equalTo(0)
            lineView.height.equalTo(0.5)
            lineView.bottom.equalTo(0)
        }

    }
}


extension MusicDownCell {

    func stopOrLoadAction(_ button: UIButton){
        print(button.isSelected)
        
        button.isSelected = !button.isSelected
        
        if button.isSelected {
            
            button.setTitle("下载", for: .normal)
            downLoadStop()
            
        }else{
        
            button.setTitle("暂停", for: .normal)
            downLoadbegin()
        }
    }
    
    
    func downLoadbegin() {
        
        let destination: DownloadRequest.DownloadFileDestination = { temporaryURL, response in
            
            let directoryURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            let folder = directoryURL.appendingPathComponent("\(AudioType.Music.rawValue)", isDirectory: true)
            let _ = FileManager.folderWith(folder.path)
            let pathComponent = response.suggestedFilename!
            let musicPath = folder.appendingPathComponent(pathComponent)
            self.music?.filePath = pathComponent
            return (musicPath, [.removePreviousFile, .createIntermediateDirectories])
        }

        self.task = Alamofire.download(resumingWith: cancelledData!,to: destination)
    }
    
    func downLoadStop() {
        self.task?.cancel()
    }
}









