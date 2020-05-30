//
//  XiaoxiViewController.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/5/26.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit

class XiaoxiViewController: WsjViewController {
   
    
    // 当前statusBar使用的样式
    var style: UIStatusBarStyle = .default
     
    // 重现statusBar相关方法
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.style
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1.先调用super.setupUI()
        super.setupUI()
        self.title = "消息"
        navigationController?.navigationBar.barTintColor = UIColor(r: 253, g: 217, b: 68)
        self.view.backgroundColor = UIColor(r: 245, g: 245, b: 245)

       
    }
    

   

}
