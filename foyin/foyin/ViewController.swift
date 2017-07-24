//
//  ViewController.swift
//  foyin
//
//  Created by  luzhaoyang on 17/6/16.
//  Copyright © 2017年 Kingstong. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
    
//        let musicVC = WLTMainMusicVC()
//        self.navigationController!.pushViewController(musicVC, animated: true)

//        let musicVC = WLTMusicDetailVC()
//        self.navigationController!.pushViewController(musicVC, animated: true)
        
        let musicVC = WLTMainMusicVC()
        self.navigationController!.pushViewController(musicVC, animated: true)
        
    
        
    }
    
        
}

