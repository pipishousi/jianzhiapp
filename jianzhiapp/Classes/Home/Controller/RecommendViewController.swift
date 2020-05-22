//
//  RecommendViewController.swift
//  DYZB
//
//  Created by 1 on 16/9/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import UIKit

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

class RecommendViewController: UIViewController {
    
    // MARK:- 懒加载属性
    private lazy var collectionView : UICollectionView = {
        //1、创建布局
        let layout = UICollectionViewFlowLayout()
        
        //2、创建collectionView
        let collectionView = UICollectionView(frame: <#T##CGRect#>, collectionViewLayout: <#T##UICollectionViewLayout#>)
    }()
}


// MARK:- 设置UI界面内容
extension RecommendViewController {
    override func setupUI() {
        // 1.先调用super.setupUI()
        super.setupUI()
        
    }
}


//// MARK:- 请求数据
//extension RecommendViewController {
//    override func loadData() {
//        // 0.给父类中的ViewModel进行赋值
//        baseVM = recommendVM
//
//        // 1.请求推荐数据
//        recommendVM.requestData {
//            // 1.展示推荐数据
//            self.collectionView.reloadData()
//
//            // 2.将数据传递给GameView
//            var groups = self.recommendVM.anchorGroups
//
//            // 2.1.移除前两组数据
//            groups.removeFirst()
//            groups.removeFirst()
//
//            // 2.2.添加更多组
//            let moreGroup = AnchorGroup()
//            moreGroup.tag_name = "更多"
//            groups.append(moreGroup)
//
//            self.gameView.groups = groups
//
//            // 3.数据请求完成
//            self.loadDataFinished()
//        }
//
//        // 2.请求轮播数据
//        recommendVM.requestCycleData {
//            self.cycleView.cycleModels = self.recommendVM.cycleModels
//        }
//    }
//}


extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    
}
