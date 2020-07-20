//
//  WuzhuangtaiViewController.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/6/5.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit

class WuzhuangtaiViewController: UIViewController {

     // MARK: 定义属性
        var contentView : UIView?
        
        // MARK: 懒加载属性
        fileprivate lazy var animImageView : UIImageView = { [unowned self] in
            let imageView = UIImageView(image: UIImage(named: "wushujuyemian"))
            imageView.center = self.view.center
//            imageView.animationImages = [UIImage(named : "img_loading_1")!, UIImage(named : "img_loading_2")!]
//            imageView.animationDuration = 0.5
//            imageView.animationRepeatCount = LONG_MAX
            imageView.frame = CGRect(x: (self.view.frame.width - 100)/2, y: 224, width: 100, height: 94)
//            imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
            return imageView
        }()
     override func viewDidLoad() {
         super.viewDidLoad()
         setupUI()
         view.backgroundColor = UIColor.green
     }
     func setupUI() {
         // 1.隐藏内容的View
         contentView?.isHidden = true
         
         // 2.添加执行动画的UIImageView
         view.addSubview(animImageView)
         
         // 3.给animImageView执行动画
         animImageView.startAnimating()
         
         // 4.设置view的背景颜色
         view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
     }

    

}
