//
//  HomeViewController.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/5/21.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
         let xiang = Common()
    var statusBarHeight: CGFloat = 0
    /// iPhoneX、iPhoneXR、iPhoneXs、iPhoneXs Max等
        /// 判断刘海屏，返回true表示是刘海屏
        ///
        
    
    // MARK:- 懒加载属性
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: xiang.kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "最新", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        
        // 1.确定内容的frame
        print(2)
        let contentH = kScreenH - xiang.kStatusBarH - (self?.navigationController!.navigationBar.frame.size.height)! - kTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: xiang.kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        // 2.确定所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
//        childVcs.append(GameViewController())
//        childVcs.append(AmuseViewController())
//        childVcs.append(FunnyViewController())
//
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
          if #available(iOS 13.0, *) {
              xiang.kStatusBarH = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
          } else {
              xiang.kStatusBarH = UIApplication.shared.statusBarFrame.height
          }
        self.view.backgroundColor = UIColor.white
        self.title = "首页"
        navigationController?.navigationBar.barTintColor = UIColor(r: 253, g: 217, b: 68)
        setupUI()
    }
    


}
extension HomeViewController {
    //设置导航栏
    private func setupUI(){
        setupNavigationbBar()
        
        // 2.添加TitleView
        view.addSubview(pageTitleView)
        
        // 3.添加ContentView
        view.addSubview(pageContentView)

    }
    
    private  func setupNavigationbBar() {
        let size = CGSize(width: 40, height: 40)
        
        //设置左侧item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "Home_x")
        
        //设置右侧item
//        let historyBtn = UIButton()
//        historyBtn.setImage(UIImage(named: "Profile_m"), for: .normal)
//        historyBtn.setImage(UIImage(named: "Profile_x"), for: .highlighted)
//        historyBtn.sizeToFit()
       let historyItem = UIBarButtonItem(imageName: "Profile_m", highImageName: "Profile_x", size: size)
        
 
        let searchItem = UIBarButtonItem(imageName: "Profile_m", highImageName: "Profile_x", size: size)
     
        let qrcodeItem = UIBarButtonItem(imageName: "Profile_m", highImageName: "Profile_x", size: size)
        
        navigationItem.rightBarButtonItems = [qrcodeItem]
    }
}
// MARK:- 遵守PageTitleViewDelegate协议
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
        print(index)
    }
}


// MARK:- 遵守PageContentViewDelegate协议
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
