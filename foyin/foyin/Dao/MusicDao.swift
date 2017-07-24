//
//  MusicDao.swift
//  Buddha
//
//  Created by 魏翔 on 17/1/16.
//  Copyright © 2017年 魏翔. All rights reserved.
//

import UIKit
import CoreData

class MusicDao: NSObject {
    
    let EntityName: String = "SoundEntiyModel"
    
    lazy var coreDataContext:NSManagedObjectContext = {
        return (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    }()
    
    // MARK: 添加音乐到表里面
    func addMusic(music: SoundModel){
        
        let musicModel = NSEntityDescription.insertNewObject(forEntityName: EntityName, into:coreDataContext) as! SoundEntiyModel
        
        //设置新增变量
        musicModel.setValue(Int(music.id), forKey: "id")
        musicModel.setValue(music.fileTitle, forKey: "fileTitle")
        musicModel.setValue(music.filePath, forKey: "filePath")
        musicModel.setValue(music.fileCover, forKey: "fileCover")
        musicModel.setValue(music.isDownLoad, forKey: "isDownLoad")
        
        do {
            try coreDataContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    
    // MARK: 根据id查询Music
    func findMusic(with id: String) -> NSManagedObject? {
        
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: EntityName)
        let condition = "id = \(id)"
        let predicate = NSPredicate(format: condition, "")
        request.predicate = predicate
        
        do{
            let resultList = try coreDataContext.fetch(request) as! [NSManagedObject]
            return resultList.first
        }catch{
            return nil
        }
    }
    
    
    // MARK: 分页查询
    func music(with page: Int, _ row: Int, finished:(_ pageModel: PageModel?,_ models:[SoundModel]?,_ error: NSError?)->()){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName)
        request.fetchOffset = (page-1) * row // 设置查找起始点，这里是从搜索结果的第(page * row)个开始获取
        request.fetchLimit = row // 设置分页，每次请求获取row个托管对象
        let sortDescirptor = NSSortDescriptor(key: "id", ascending: true) // 设置排序规则，这里按id设置升序排序
        request.sortDescriptors = [sortDescirptor]
        var models:[SoundModel] = []
        
        do{
            let resultList = try coreDataContext.fetch(request) as! [NSManagedObject]
            for result in resultList{
                models.append(SoundModel.mj_object(withKeyValues: result))
            }
            
            let totalRows = totalMusicCount()
            let totalPage = (totalRows % row == 0) ? Int(totalRows / row) : Int(totalRows / row) + 1
            let pageModel = PageModel()
            pageModel.currentPage = page
            pageModel.onePageRows = row
            pageModel.totalPage = totalPage
            pageModel.totalRows = totalRows
            finished(pageModel, models, nil)
            
        }catch{
            
            let error = NSError(domain: ErrorDomain, code: 100, userInfo: [ErrorKey: "暂无数据"])
            finished(nil, nil, error)
        }
    }
    
    func totalMusicCount() -> Int {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName)
        
        do{
            let resultList = try coreDataContext.fetch(request) as! [NSManagedObject]
            return resultList.count
            
        }catch{
            return 0
        }
    }
    
    
    // MARK: 删除
    func delMusic(id: String) {
        
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: EntityName)
        let condition = "id = \(id)"
        let predicate = NSPredicate(format: condition, "")
        request.predicate = predicate
        
        do{
            
            let resultsList = try coreDataContext.fetch(request) as! [NSManagedObject]
            if resultsList.count != 0 {//若结果为多条，则只删除第一条，可根据你的需要做改动
                coreDataContext.delete(resultsList[0])
                try coreDataContext.save()
            }
            
        }catch{
            print("delete fail !")
        }
    }

}
