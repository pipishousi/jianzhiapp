//
//  MainViewController.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/5/20.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addchildvc(storyName: "Home")
        addchildvc(storyName: "Live")
        addchildvc(storyName: "Follow")
        

        
    }
    private func addchildvc(storyName:String){
        //通过storyboard获取控制器
        
        let childVC = UIStoryboard(name:storyName, bundle: nil).instantiateInitialViewController()!
        
        //将childVC作为子控制器
        addChild(childVC)
    }


}
