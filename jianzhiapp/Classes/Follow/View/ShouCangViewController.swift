//
//  ShouCangViewController.swift
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
class ShouCangViewController: WuzhuangtaiViewController {
    var JobOffersdata: Results<JobOffers>?
      // 获取默认的 Realm 数据库
      let realm = try! Realm()
    // MARK:- 懒加载属性
    private lazy var collectionShouCangView : UICollectionView = {[unowned self] in
        //1、创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenW, height: kItemH)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        //2、创建collectionView
        let collectionShouCangView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionShouCangView.backgroundColor = UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        collectionShouCangView.dataSource = self
        collectionShouCangView.delegate = self
        collectionShouCangView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionShouCangView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: KNrmalCellID)
        
        return collectionShouCangView
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
        JobOffersdata = realm.objects(JobOffers.self).filter("shoucang == true")
        if JobOffersdata!.count < 0 {
             // 1.先调用super.setupUI()
                   super.setupUI()
        }
        view.addSubview(collectionShouCangView)
//        view.backgroundColor = UIColor.white
    }
    


}
// MARK:- 遵守协议
extension ShouCangViewController: UICollectionViewDataSource{
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

extension ShouCangViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
}
