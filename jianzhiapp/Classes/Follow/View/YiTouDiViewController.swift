//
//  YiTouDiViewController.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/6/3.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit
import RealmSwift
private let kItemH : CGFloat = kScreenW*1/3
private let KNrmalCellID = "KNrmalCellID"
private let kTitleViewH : CGFloat = 40

enum Mode {
    case view
    case select
}
class YiTouDiViewController: WuzhuangtaiViewController {
    
    //
    var mMode: Mode = .view{
        didSet{
            switch mMode {
            case .view:
                selectBarButton.title = "编辑"
                navigationItem.leftBarButtonItem = nil
                //禁止用户多选
                collectionYiTouDiView.allowsMultipleSelection = false
            case .select:
                selectBarButton.title = "取消编辑"
                navigationItem.leftBarButtonItem = deletBarButton
                //允许用户多选
                collectionYiTouDiView.allowsMultipleSelection = true
            }
        }
    }
    lazy var selectBarButton: UIBarButtonItem = {
        let barButtonitem = UIBarButtonItem(title: "编辑", style: .plain, target: self, action: #selector(didSelectBarButtonClicked(_:)))
        return barButtonitem
    }()
    lazy var deletBarButton: UIBarButtonItem = {
        let barButtonitem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didDeletBarButtonClicked(_:)))
        return barButtonitem
    }()
    var dictionarySelectedIndecPath: [IndexPath: Bool] = [:]
    var JobOffersdata: Results<JobOffers>?
    // 获取默认的 Realm 数据库
    let realm = try! Realm()
    // MARK:- 懒加载属性
    private lazy var collectionYiTouDiView : UICollectionView = {[unowned self] in
        //1、创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenW, height: kItemH)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        //2、创建collectionView
        let collectionYiTouDiView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionYiTouDiView.backgroundColor = UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        collectionYiTouDiView.dataSource = self
        collectionYiTouDiView.delegate = self
        collectionYiTouDiView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionYiTouDiView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: KNrmalCellID)
        
        return collectionYiTouDiView
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupBarButtonItems()
        JobOffersdata = realm.objects(JobOffers.self).filter("Delivery == true")
        if JobOffersdata!.count < 0 {
            // 1.先调用super.setupUI()
            super.setupUI()
        }
        view.addSubview(collectionYiTouDiView)
        //        view.backgroundColor = UIColor.white
    }
    
    private func setupBarButtonItems(){
        navigationItem.rightBarButtonItem = selectBarButton
    }
    
    
}
extension YiTouDiViewController{
    @objc func didSelectBarButtonClicked(_ sender: UIBarButtonItem){
        mMode = mMode == .view ? .select : .view
    }
    @objc func didDeletBarButtonClicked(_ sender: UIBarButtonItem){
        var deleteNeededIndexPaths: [IndexPath] = []
           for (key, value) in dictionarySelectedIndecPath {
             if value {
               deleteNeededIndexPaths.append(key)
             }
        }
        for i in deleteNeededIndexPaths.sorted(by: { $0.item > $1.item }) {
            try! realm.write {
                realm.delete(JobOffersdata![i.item])
            }
         
        }
        
        collectionYiTouDiView.deleteItems(at: deleteNeededIndexPaths)
        self.collectionYiTouDiView.reloadData()
    }
}
// MARK:- 遵守协议
extension YiTouDiViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return JobOffersdata!.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNrmalCellID, for: indexPath) as! CollectionNormalCell
        
        
        cell.Job.text = JobOffersdata![indexPath.item].Job
        cell.Education.text = JobOffersdata![indexPath.item].Education
        cell.Postlabel.text = JobOffersdata![indexPath.item].Postlabel
        cell.Workingyears.text = JobOffersdata![indexPath.item].Workingyears
        cell.company.text = JobOffersdata![indexPath.item].company
        cell.Listed.text = JobOffersdata![indexPath.item].Listed
        cell.Staff.text = JobOffersdata![indexPath.item].Staff
        let imageurl = "\(JobOffersdata![indexPath.item].AvatarImage)"
        //定义URL对象
        let url = URL(string: imageurl)
        cell.AvatarImage.af_setImage(withURL: url!)
        cell.nicknameposition.text = "\(JobOffersdata![indexPath.item].position)" + "·" + "\(JobOffersdata![indexPath.item].nickname)"
        cell.Salary.text = JobOffersdata![indexPath.item].Salary
        cell.Jobcity.text = JobOffersdata![indexPath.item].Jobcity
        cell.backgroundColor = UIColor.white
        
        return cell
    }
    
    
    
    
    
    
    
    
}
//Mark  遵守代理协议

extension YiTouDiViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch mMode {
        case .view:
            collectionYiTouDiView.deselectItem(at: indexPath, animated: true)
            
        case .select:
            dictionarySelectedIndecPath[indexPath] = true
            break
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if mMode == .select {
            dictionarySelectedIndecPath[indexPath] = false
        }
    }
}
