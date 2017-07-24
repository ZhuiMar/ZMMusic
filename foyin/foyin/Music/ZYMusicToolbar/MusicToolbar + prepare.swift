//
//  MusicToolbar + prepare.swift
//  foyin
//
//  Created by  luzhaoyang on 17/6/22.
//  Copyright © 2017年 Kingstong. All rights reserved.
//

import Foundation
import SVProgressHUD

// MARK: 拿到将要播放的musicModel & 下标值
extension MusicToolbar {

    // MARK: 下一首
    func nextMusicIndex() -> Int {
        
        var nextIndex = currentMusicIndex() + 1
        if (nextIndex >= musicModels.count) {
            nextIndex = 0
        }
        return nextIndex
    }
    
    func nextMusicModel() -> SoundModel{
        let nextMusic = musicModels[nextMusicIndex()]
        return nextMusic
    }
    
    
    // MARK: 上一首
    func preMusicIndex() -> Int {
        
        var previousIndex = currentMusicIndex() - 1
        if (previousIndex < 0) {
            previousIndex = musicModels.count - 1
        }
        return previousIndex
    }
    
    func preMusicModel() -> SoundModel{
        let preMusic = musicModels[preMusicIndex()]
        return preMusic
    }
    
    // MARK: 随机播放
    func randomMusicModel()-> (SoundModel, Int) {
        
        let randomIndex: UInt32 = (arc4random() % UInt32(musicModels.count))
        let index = Int(randomIndex)
        let model = musicModels[index]
        return (model, index)
    }
    

    // MARK: 单曲循环
    func circleMusicModel()-> SoundModel{
        return musicModels[currentMusicIndex()]
    }

    
    func currentMusicIndex() -> Int {
        
        print(currentMusicModel)
        print(musicModels)
        
        let currentIndex: Int = (musicModels.index(of: currentMusicModel!))!
        return currentIndex
    }
    
}
