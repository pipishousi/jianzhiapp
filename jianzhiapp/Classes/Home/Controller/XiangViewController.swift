//
//  XiangViewController.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/5/24.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit
import RealmSwift
import CLToast
private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90
private let kItemW : CGFloat = 90
private let kItemH : CGFloat = kScreenW*1/3
private let KXiangCellID = "KXiangCellID"

enum Shoucang {
    case shoucang
    case quxiaoshoucang
}

class XiangViewController: UIViewController{
    
    var sShoucang: Shoucang = .shoucang{
        didSet{
            switch sShoucang {
            case .shoucang:
                selectBarButton.image = UIImage(named: "shoucang_h")
                print(1)
            case .quxiaoshoucang:
                selectBarButton.image = UIImage(named: "shoucang_m")
                print(2)
            }
        }
    }
    lazy var selectBarButton: UIBarButtonItem = {
        let barButtonitem = UIBarButtonItem(image:  UIImage(named: "shoucang_m"), style: .plain, target: self, action: #selector(didSelectBarButtonClicked(_:)))
        //        (barButtonSystemItem: .trash, target: self, action: #selector(didSelectBarButtonClicked(_:)))
        return barButtonitem
        
    }()
    @objc func didSelectBarButtonClicked(_ sender: UIBarButtonItem){
        sShoucang = sShoucang == .shoucang ? .quxiaoshoucang : .shoucang
    }
    //更新数据
    let batch = BmobObjectsBatch()
    var Jobid : String?
    // 获取默认的 Realm 数据库
    let realm = try! Realm()
    var  userzhanghao :Results<User>?
    var tanDogs: Results<JobOffers>?
    var streing:String?
    let rightBtn = UIButton()
    let xiang = Common()
    //自定义导航栏关闭按钮
    lazy var Deliverybtn : CustomBtn = CustomBtn()
    // MARK:- 懒加载属性-提示弹窗
    // MARK:- 懒加载属性
    private lazy var recommendVc : RecommendViewController = RecommendViewController()
    // MARK:- 懒加载属性
    private lazy var xiangqingView : UICollectionView = {[unowned self] in
        //1、创建布局
        let layout = UICollectionViewFlowLayout()
        //        layout.itemSize = CGSize(width:kScreenW, height: 600)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        //2、创建collectionView
        let cgrect = CGRect(x: 0, y: 0, width:  self.view.frame.width, height: self.view.frame.height - 48 -  bottomSafeAreaHeight)
        let xiangqingView = UICollectionView(frame:cgrect, collectionViewLayout: layout)
        xiangqingView.backgroundColor = UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        xiangqingView.dataSource = self
        xiangqingView.delegate = self
        xiangqingView.backgroundColor = UIColor.white
        xiangqingView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        xiangqingView.register(UINib(nibName: "CollectionXinagCell", bundle: nil), forCellWithReuseIdentifier: KXiangCellID)
        return xiangqingView
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //        setupBarButtonItems()
        view.backgroundColor = UIColor.white
        userzhanghao = realm.objects(User.self)
        tanDogs = realm.objects(JobOffers.self).filter("id CONTAINS '\(Jobid!)'")
        if tanDogs![0].shoucang == true {
            rightBtn.setImage(UIImage.init(named: "shoucang_h"), for: .normal)
            rightBtn.tag = 1
        }else{
            rightBtn.setImage(UIImage.init(named: "shoucang_m"), for: .normal)
            rightBtn.tag = 2
            
        }
        xiang.KXinagH = getLabelTextHeight(font: UIFont.systemFont(ofSize: 16), width: kScreenW-30)(streing)
        setupUI()
        
    }
    
    private func setupBarButtonItems(){
        navigationItem.rightBarButtonItem = selectBarButton
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
extension XiangViewController{
    
    private func setupUI(){
        setupNavigationbBar()
        //按钮样式
        Deliverybtn.frame = CGRect(x: 0, y: self.view.frame.height - 48 - bottomSafeAreaHeight, width: kScreenW, height: 48 + bottomSafeAreaHeight)

        Deliverybtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        Deliverybtn.addTarget(self, action: #selector(XiangViewController.DeliveryClick(sender:)), for: .touchUpInside)
        
        view.addSubview(Deliverybtn)
        view.addSubview(xiangqingView)
        
    }
    private  func setupNavigationbBar() {
        //设置左侧item
        let szie = CGSize(width: 40, height: 40)
        
        //        rightBtn.imageView?.contentMode = .scaleAspectFill
        rightBtn.transform = CGAffineTransform(scaleX: 0.60, y: 0.60);
        
        
        //        rightBtn.frame = CGRect(origin: CGPoint.zero, size: szie)
        rightBtn.sizeToFit()
        //        rightBtn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        rightBtn.addTarget(self, action: #selector(XiangViewController.city(sender:)), for: .touchUpInside)
        let rightBtns = UIBarButtonItem(customView: rightBtn)
        
        
        
        navigationItem.rightBarButtonItems = [rightBtns]
        
    }
    
    @objc func city(sender: UIButton) {
        let user = BmobUser.getCurrent()
        if user != nil {
            if rightBtn.tag == 2 {
                CLToast.cl_show(msg: "收藏成功", onView: self.view, duration: 1)
                rightBtn.setImage(UIImage.init(named: "shoucang_h"), for: .normal)
                
                recommendVc.refresh()
                let JobOffer = JobOffers()
                JobOffer.shoucang = true
                JobOffer.id = "\(Jobid!)"
                try! realm.write {
                    realm.add(JobOffer, update: .modified)
                }
                batch.updateBmobObject(withClassName: "JobOffers", objectId: "\(Jobid!)", parameters: ["shoucang":true])
                batch.batchObjectsInBackground { (isSuccessful, error) in
                    if error != nil {
                        print("error \(error!.localizedDescription)")
                    }
                }
                rightBtn.tag = 1
                
            }else{
                if rightBtn.tag == 1 {
                    CLToast.cl_show(msg: "已取消收藏", onView: self.view, duration: 1)
                    rightBtn.setImage(UIImage.init(named: "shoucang_m"), for: .normal)
                    
                    recommendVc.refresh()
                    let JobOffer = JobOffers()
                    JobOffer.shoucang = true
                    JobOffer.id = "\(Jobid!)"
                    try! realm.write {
                        realm.add(JobOffer, update: .modified)
                    }
                    batch.updateBmobObject(withClassName: "JobOffers", objectId: "\(Jobid!)", parameters: ["shoucang":false])
                    batch.batchObjectsInBackground { (isSuccessful, error) in
                        if error != nil {
                            print("error \(error!.localizedDescription)")
                        }
                    }
                    rightBtn.tag = 2
                    
                }
            }
            
        }else{
            simpleHint(message:"请先登录")
        }
        
        
    }
    
}
extension XiangViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tanDogs!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = xiangqingView.dequeueReusableCell(withReuseIdentifier: KXiangCellID, for: indexPath) as! CollectionXinagCell
        
        cell.Job.text = tanDogs![indexPath.item].Job
        cell.Salary.text = tanDogs![indexPath.item].Salary
        cell.Workingyears.text = tanDogs![indexPath.item].Workingyears
        cell.Education.text = tanDogs![indexPath.item].Education
        cell.jobRequirements.text = tanDogs![indexPath.item].jobRequirements
        cell.companyposition.text = tanDogs![indexPath.item].company + "" + tanDogs![indexPath.item].position
        cell.nickname.text = tanDogs![indexPath.item].nickname
        //        cell.AvatarImage.image = tanDogs[indexPath.item].AvatarImage
        cell.Jobcity.text = tanDogs![indexPath.item].Jobcity
        
        //        cell.backgroundColor = UIColor.red
        return cell
    }
    
    
    
    
}

extension XiangViewController : UICollectionViewDelegateFlowLayout{
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kScreenW, height: xiang.KXinagH+284+260)
    }
}

extension XiangViewController {
    //立即投递事件
    @objc func DeliveryClick(sender:UIButton) {
        if Deliverybtn.isHighlighted == true {
            
            
            //判断是否登录
            let user = BmobUser.getCurrent()
            if user != nil {
                recommendVc.refresh()
                let JobOffer = JobOffers()
                JobOffer.Delivery = true
                JobOffer.id = "\(Jobid!)"
                try! realm.write {
                    realm.add(JobOffer, update: .modified)
                }
                batch.updateBmobObject(withClassName: "JobOffers", objectId: "\(Jobid!)", parameters: ["Delivery":true])
                batch.batchObjectsInBackground { (isSuccessful, error) in
                    if error != nil {
                        print("error \(error!.localizedDescription)")
                    }
                }
                // 展示在指定view上默认2秒，可指定时间
                CLToast.cl_show(msg: "投递成功", onView: self.view, duration: 1)
                Deliverybtn.setTitle("已投递", for: .normal)
                Deliverybtn.isHighlighted = false
                Deliverybtn.backgroundColor = UIColor(r: 245, g: 245, b: 245)
            }else{
                simpleHint(message:"请先登录")
            }
            
            
            
        }
        
    }
    //计算字符串的高度
    func getLabelTextHeight(font: UIFont, width: CGFloat) -> (_ string: String?) -> CGFloat {
        return { text in
            guard let textString = text else {
                return 0
            }
            var attrButes:[NSAttributedString.Key : Any]! = nil;
            let paraph = NSMutableParagraphStyle()
            paraph.lineSpacing = 0.5
            attrButes = [NSAttributedString.Key.font:font, NSAttributedString.Key.paragraphStyle:paraph]
            let size:CGRect = textString.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrButes, context: nil)
            return size.height
        }
    }
}
//弹窗样式
extension XiangViewController{
    //摊框
    func simpleHint(message:String) {
        // 建立一個提示框
        let alertController = UIAlertController(
            title: "提示",
            message: message,
            preferredStyle: .alert)
        
        // 建立[確認]按鈕
        let okAction = UIAlertAction(
            title: "我知道了",
            style: .default,
            handler: {
                (action: UIAlertAction!) -> Void in
        })
        alertController.addAction(okAction)
        
        // 顯示提示框
        self.present(
            alertController,
            animated: true,
            completion: nil)
    }
}
