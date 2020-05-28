//
//  MeViewController.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/5/26.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit
private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90
private let kItemW : CGFloat = 90
private let kItemH : CGFloat = 60
private let KMeCellID = "KMeCellID"
private let kTitleViewH : CGFloat = 40
class MeViewController: UIViewController {
   
    // MARK:- 懒加载属性
    private lazy var collectionMeView : UICollectionView = {[unowned self] in
        //1、创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenW, height: kItemH)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        //2、创建collectionView
        let collectionMeView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionMeView.backgroundColor = UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        collectionMeView.dataSource = self
        collectionMeView.delegate = self
        collectionMeView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionMeView.register(UINib(nibName: "CollectionMeCell", bundle: nil), forCellWithReuseIdentifier: KMeCellID)
        return collectionMeView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        print("213123")
        setupUI()
    }
    


}
// MARK:- 设置UI界面内容
extension MeViewController {
    private func setupUI(){
        view.addSubview(collectionMeView)
      
       }
}
// MARK:- 遵守协议
extension MeViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KMeCellID, for: indexPath)
        
        cell.backgroundColor = UIColor.white
        
        return cell
    }
    
    
    
    
    
    
    
    
}
//Mark  遵守代理协议

extension MeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let xiangVc = XiangViewController()
//        xiangVc.streing = string
//        navigationController?.pushViewController(xiangVc, animated: true)
    }
}

