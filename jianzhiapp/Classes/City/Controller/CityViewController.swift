//
//  CityViewController.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/5/31.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit
private let kEdgeMargin : CGFloat = 15
private let kHeaderViewH : CGFloat = 50
private let kItemW : CGFloat = (kScreenW - 2*kEdgeMargin - 20)/3
private let kItemH : CGFloat = kItemW*1/4
private let CityHeaderCellID = "CityHeaderCellID"
private let CityCellID = "CityCellID"

protocol CityDelegate {
    func CityData(city: String)
}
class CityViewController: UIViewController {
    let xiang = Common()
    let cityjianpin:[String] = ["A","B","C","D","E","F","G","H","J","K","L","M","N","P","Q","R","S","T","W","X","Y","Z",]
    var delegate: CityDelegate?
    //自定义导航栏
    fileprivate lazy var citynavgate : UIView = {
        let citynavgate = UIView()
        citynavgate.backgroundColor = UIColor.white
        return citynavgate
    }()
    //自定义导航栏关闭按钮
    lazy var Citybtn : CustomBtn = CustomBtn()
    // MARK:- 懒加载属性
       private lazy var recommendMV : RecomendViewModel = RecomendViewModel()
    // MARK:- 懒加载属性
    private lazy var cityView : UICollectionView = {[unowned self] in
        //1、创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:kItemW, height: kItemH)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 15, left: kEdgeMargin, bottom: 15, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        //2、创建collectionView
        let cityheightH = kScreenH - xiang.kStatusBarH - kNavigationBarH
        let cityframe = CGRect(x: 0, y: 88, width:kScreenW, height: cityheightH)
        let cityView = UICollectionView(frame: cityframe, collectionViewLayout: layout)
        cityView.backgroundColor = UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        cityView.dataSource = self
        cityView.delegate = self
        cityView.backgroundColor = UIColor.white
        cityView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        cityView.register(UINib(nibName: "CollectionCityCell", bundle: nil), forCellWithReuseIdentifier: CityCellID)
        cityView.register(UINib(nibName: "CollectionCityHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CityHeaderCellID)
        return cityView
        }()
     var  vc: RecommendViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        xiang.dangqiancity = "北京"
        
        //设置UI界面
        setupUI()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
//设置UI界面
extension CityViewController{
    private func setupUI(){
        
        view.addSubview(cityView)
        //导航栏布局
        view.addSubview(citynavgate)
        citynavgate.frame = CGRect(x: 0, y:0, width:kScreenW, height: 88)
        citynavgate.buttomBorder(width: 1, borderColor: UIColor(r: 245, g: 245, b: 245))
        //按钮样式
        Citybtn.frame = CGRect(x: 6, y: kNavigationBarH, width: 50, height: 20)
        Citybtn.setTitle("关闭", for: .normal)
        Citybtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        Citybtn.addTarget(self, action: #selector(CityViewController.CitybtnClick(sender:)), for: .touchUpInside)
        citynavgate.addSubview(Citybtn)
        
    }
}
extension CityViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cityjianpin.count + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return xiang.citys["hot"]!.count
        case 2:
            return xiang.citys["A"]!.count
        case 3:
            return xiang.citys["B"]!.count
        case 4:
            return xiang.citys["C"]!.count
        case 5:
           return xiang.citys["D"]!.count
        case 6:
            return xiang.citys["E"]!.count
        case 7:
            return xiang.citys["F"]!.count
        case 8:
            return xiang.citys["G"]!.count
        case 9:
            return xiang.citys["H"]!.count
        case 10:
            return xiang.citys["J"]!.count
        case 11:
            return xiang.citys["K"]!.count
        case 12:
           return xiang.citys["L"]!.count
        case 13:
            return xiang.citys["M"]!.count
        case 14:
            return xiang.citys["N"]!.count
        case 15:
            return xiang.citys["P"]!.count
        case 16:
            return xiang.citys["Q"]!.count
        case 17:
            return xiang.citys["S"]!.count
        case 18:
            return xiang.citys["T"]!.count
        case 19:
           return xiang.citys["Y"]!.count
        case 20:
            return xiang.citys["W"]!.count
        case 21:
            return xiang.citys["X"]!.count
        case 22:
            return xiang.citys["Y"]!.count
        case 23:
            return xiang.citys["Z"]!.count
        default:
            break
        }
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cityView.dequeueReusableCell(withReuseIdentifier: CityCellID, for: indexPath) as! CollectionCityCell
        let subStringTo5 = indexPath.section
        switch subStringTo5 {
        case 0:
            cell.citylabel.text = "杭州市"
        case 1:
            cell.citylabel.text = xiang.citys["hot"]![indexPath.item]
        case 2:
            cell.citylabel.text = xiang.citys["A"]![indexPath.item]
        case 3:
            cell.citylabel.text = xiang.citys["B"]![indexPath.item]
        case 4:
            cell.citylabel.text = xiang.citys["C"]![indexPath.item]
        case 5:
            cell.citylabel.text = xiang.citys["D"]![indexPath.item]
        case 6:
            cell.citylabel.text = xiang.citys["E"]![indexPath.item]
        case 7:
            cell.citylabel.text = xiang.citys["F"]![indexPath.item]
        case 8:
            cell.citylabel.text = xiang.citys["G"]![indexPath.item]
        case 9:
            cell.citylabel.text = xiang.citys["H"]![indexPath.item]
        case 10:
            cell.citylabel.text = xiang.citys["J"]![indexPath.item]
        case 11:
            cell.citylabel.text = xiang.citys["K"]![indexPath.item]
        case 12:
            cell.citylabel.text = xiang.citys["L"]![indexPath.item]
        case 13:
            cell.citylabel.text = xiang.citys["M"]![indexPath.item]
        case 14:
            cell.citylabel.text = xiang.citys["N"]![indexPath.item]
        case 15:
            cell.citylabel.text = xiang.citys["P"]![indexPath.item]
        case 16:
            cell.citylabel.text = xiang.citys["Q"]![indexPath.item]
        case 17:
            cell.citylabel.text = xiang.citys["S"]![indexPath.item]
        case 18:
            cell.citylabel.text = xiang.citys["T"]![indexPath.item]
        case 19:
            cell.citylabel.text = xiang.citys["Y"]![indexPath.item]
        case 20:
            cell.citylabel.text = xiang.citys["W"]![indexPath.item]
        case 21:
        cell.citylabel.text = xiang.citys["X"]![indexPath.item]
        case 22:
            cell.citylabel.text = xiang.citys["Y"]![indexPath.item]
        case 23:
            cell.citylabel.text = xiang.citys["Z"]![indexPath.item]
        default:
            break
        }
        cell.layer.cornerRadius = 4
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CityHeaderCellID, for: indexPath) as! CollectionCityHeaderView
        if indexPath.section == 0 {
            headerView.cityindex.text = "定位城市"
        }else{
            if indexPath.section == 1 {
                headerView.cityindex.text = "热门城市"
            }else{
                let citysection = indexPath.section - 2
                headerView.cityindex.text = cityjianpin[citysection]
                
            }
        }
        
        // 2.给HeaderView设置属性
        //        headerView.ci
        
        return headerView
    }
    
}
//遵守代理协议
extension CityViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
           return true
       }
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor(r: 255, g: 213, b: 70)
        
       
    }
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
           let cell = collectionView.cellForItem(at: indexPath)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25) {
            cell?.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        }
//           delay(0.25) {
//
//           }
       }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
//            delegate?.CityData(city: "杭州")
        }else{
            if indexPath.section == 1 {
               // 发送简单数据
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: xiang.citys["hot"]![indexPath.item]), object: "Hello 2017")

               
//                recommendMV.requestgognzuoxinxiData(gongzuoxinxiCallback: xiang.citys["hot"]![indexPath.item].replacingOccurrences(of: "市", with: "")){
//
//                }
                let city = xiang.citys["hot"]![indexPath.item]
//                /// 发送额外数据
                let cityjob = String(city.prefix(2))
                let info = ["name":"city","city":"\(cityjob)"] as [String : Any]
                NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "XMNotification"), object: cityjob, userInfo: info)
//
                
                delegate?.CityData(city: city.replacingOccurrences(of: "市", with: ""))
            }else{
               
                delegate!.CityData(city: xiang.citys[cityjianpin[indexPath.section-2]]![indexPath.item].replacingOccurrences(of: "市", with: ""))
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
}
//关闭当前页面
extension CityViewController{
    
    @objc fileprivate func CitybtnClick(sender:UIButton) {
        sender.isSelected = !sender.isSelected
        self.dismiss(animated: true, completion: nil)
        
    }
}
