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
private let kItemW : CGFloat = 90
private let kItemH : CGFloat = kScreenW*1/3
private let KNrmalCellID = "KNrmalCellID"

class RecommendViewController: UIViewController {
    let string = """
       你需要完成这样的工作:

       1、负责公司所有产品线的交互设计，包括Web、ios、Android、Windows/Mac客户端;

       2、与产品经理沟通，协助其系统地梳理需求并根据需求完成交互原型设计:

       3、建立和主导公司的交互设计风格;

       4、参与部门内外用户体验相关的工作。

       我们需要这样的你:

       1、本科及以上专业，工业设计等相关专业优先;

       2、2年以上互联网产品交互设计工作经验，有各个平台的项目经验的优先(投递简历请附上作品)

       3、热爱设计，享受设计，有志设计出拥有最佳用户体验的办公产品;

       4、熟练使用常见的设计工具和设计表现方法;

       5、关注用户需求，具备较强的逻辑思维能力;

       6、具备团队意识和能力，能够高效和融洽的与各角色的人员协同工作;

       7、善于学习，乐于创新。
       """
    // MARK:- 懒加载属性
    private lazy var collectionView : UICollectionView = {[unowned self] in
        //1、创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenW, height: kItemH)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        //2、创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: KNrmalCellID)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        setupUI()
    }
   
}


// MARK:- 设置UI界面内容
extension RecommendViewController {
    private func setupUI(){
        view.addSubview(collectionView)
      
       }
}

// MARK:- 遵守协议
extension RecommendViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNrmalCellID, for: indexPath)
        
        cell.backgroundColor = UIColor.white
        
        return cell
    }
    
    
    
    
}
//Mark  遵守代理协议

extension RecommendViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let xiangVc = XiangViewController()
        xiangVc.streing = string
        navigationController?.pushViewController(xiangVc, animated: true)
    }
}
//// MARK:- 请求数据
extension RecommendViewController {
   
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
}


extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    
}
