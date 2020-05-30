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
private let KGRCellID = "KGRCellID"
private let kTitleViewH : CGFloat = 40
class MeViewController: UIViewController {
    lazy var btn : CustomBtn = CustomBtn()
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
        collectionMeView.register(UINib(nibName: "CollectionGRViewCell", bundle: nil), forCellWithReuseIdentifier: KGRCellID)
        
        return collectionMeView
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
    }
    
    
    
}
// MARK:- 设置UI界面内容
extension MeViewController {
    private func setupUI(){
        view.addSubview(collectionMeView)
        navigationController?.navigationBar.barTintColor = UIColor(r: 255, g: 213, b: 70)
        
        //按钮样式
        btn.frame = CGRect(x: 112, y: 34, width: 100, height: 50)
        btn.setTitle("登录", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        //        btn.center = view.center
        btn.addTarget(self, action: #selector(MeViewController.btnClick(sender:)), for: .touchUpInside)
        
        
    }
}

// MARK:- 遵守协议
extension MeViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item ==  0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KGRCellID, for: indexPath) as! CollectionGRViewCell
            
            cell.addSubview(btn)
            
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KMeCellID, for: indexPath) as! CollectionMeCell
        
        
        return cell
    }
    
    
    
    
    
    
    
    
}
//Mark  遵守代理协议

extension MeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
}
extension MeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: kScreenW, height: 213)
        }
        return CGSize(width: kScreenW, height:142)
    }
}


//MARK:- 事件监听
extension MeViewController: LigonMeDelegate{
    func LigonusernameData(username: String) {
        btn.setTitle(username, for: .normal)
    }
    
    
    @objc fileprivate func btnClick(sender:UIButton) {
        sender.isSelected = !sender.isSelected
        let login = LigonViewController()
        login.delegate = self
        self.navigationController?.pushViewController(login, animated: true)
    }
    
}
