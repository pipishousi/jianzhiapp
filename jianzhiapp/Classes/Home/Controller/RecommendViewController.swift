//
//  RecommendViewController.swift
//  DYZB
//
//  Created by 1 on 16/9/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import UIKit
import RealmSwift
private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90
private let kItemW : CGFloat = 90
private let kItemH : CGFloat = 115
private let KNrmalCellID = "KNrmalCellID"
private let KNrmalCellID2 = "KNrmalCellID2"
private let kTitleViewH : CGFloat = 40
class RecommendViewController: WsjViewController, UICollectionViewDataSource {
    
//    var JobOffersdata : Results<JobOffers>?
//    let JobDatas = Common()
    let xiang = Common()
    // 获取默认的 Realm 数据库
    let realm = try! Realm()
    var string = "杭州"
    //金刚区菜单
    lazy var rezhaojianzhibtn :UIButton = UIButton()
    lazy var zuixinjianzhibtn :UIButton = UIButton()
    lazy var dengtarenwubtn :UIButton = UIButton()
    lazy var dengtazixunbtn :UIButton = UIButton()
    
    var Gongzuoxinxidata: Results<Gongzuoxinxi>?
    //    var JobOffer: Results<JobOffers>?
    let jingangquview = UIView()
    // MARK:- 懒加载属性
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: animImageView.frame.height+120, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "最新"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
        }()
    // MARK: 懒加载属性
    fileprivate lazy var animImageView : UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "hdgz"))
        imageView.center = self.view.center
        
        imageView.frame = CGRect(x:0, y:0, width: kScreenW, height: kItemH)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 0
        return imageView
        }()
    
    // MARK:- 懒加载属性
    private lazy var recommendMV : RecomendViewModel = RecomendViewModel()
    // MARK:- 懒加载属性
    private lazy var collectionView : UICollectionView = {[unowned self] in
        //1、创建布局
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: animImageView.frame.height+118, left: 0,
                                           bottom: 0, right: 0)
        
        layout.itemSize = CGSize(width: kScreenW, height: kItemH)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        //2、创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.black
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: KNrmalCellID)
        collectionView.register(UINib(nibName: "CollectionXinagZWCell", bundle: nil), forCellWithReuseIdentifier: KNrmalCellID2)
        
        return collectionView
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 通知名
        let notificationName = "XMNotification"
        /// 自定义通知
        NotificationCenter.default.addObserver(self, selector: #selector(notificationAction), name: NSNotification.Name(rawValue: notificationName), object: nil)
        //加载样式
        self.collectionView.gtm_addRefreshHeaderView {
            [weak self] in
            print("excute refreshBlock")
            self?.refresh()
        }
        
        self.collectionView.gtm_addLoadMoreFooterView {
            [weak self] in
            print("excute loadMoreBlock")
            self?.loadMore()
        }
        //请求数据
        loadData(city: string)
        Gongzuoxinxidata = realm.objects(Gongzuoxinxi.self).filter("gongzuochengshi BEGINSWITH '\(string)'")
        print(Gongzuoxinxidata![0].biaoti)
        //布局UI样式
        setrupUI()
        //布局金刚区菜单
        setrupjingangquUI()
    }
    /// 接受到通知后的方法回调
    @objc private func notificationAction(noti: Notification) {
        /// 获取键盘的位置/高度/时间间隔...
        
        print(string)
        if (noti.userInfo!["name"])! as! String == "city" {
            DispatchQueue.main.async {
                self.string = noti.userInfo!["city"] as! String
                
            }
            Gongzuoxinxidata = realm.objects(Gongzuoxinxi.self).filter("gongzuochengshi BEGINSWITH '\(noti.object!)'")
            self.collectionView.reloadData()
        }else{
            if (noti.userInfo!["name"])! as! String == "tuijian" {
                print(string)
                Gongzuoxinxidata = realm.objects(Gongzuoxinxi.self).filter("gongzuochengshi BEGINSWITH '\(string)'")
                self.collectionView.reloadData()
            }else{
                Gongzuoxinxidata = realm.objects(Gongzuoxinxi.self).filter("gongzuochengshi BEGINSWITH '\(string)'").sorted(byKeyPath: "updatedAt", ascending: false)
                self.collectionView.reloadData()
            }
            
        }
        
    }
    /// 析构函数.类似于OC的 dealloc
    deinit {
        /// 移除通知
        NotificationCenter.default.removeObserver(self)
    }
    // MARK: Test
    func refresh() {
        
        perform(#selector(endRefresing), with: nil, afterDelay: 2)
        
    }
    
    @objc func endRefresing() {
        
        self.collectionView.endRefreshing(isSuccess: true)
        
        self.collectionView.reloadData()
        self.loadDataFinished()
        
    }
    func loadMore() {
        perform(#selector(endLoadMore), with: nil, afterDelay: 3)
    }
    
    @objc func endLoadMore() {
        self.collectionView.endLoadMore(isNoMoreData: true)
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        let gongzuoxinxicount = recommendMV.gongzuoxinxis
        print("第一次")
                print(Gongzuoxinxidata!.count)
        return Gongzuoxinxidata!.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNrmalCellID2, for: indexPath) as! CollectionXinagZWCell
        
        cell.biaoti.text = Gongzuoxinxidata![indexPath.item].biaoti
        cell.gongzi.text = Gongzuoxinxidata![indexPath.item].gongzi
        cell.gongzuochengshi.text = Gongzuoxinxidata![indexPath.item].gongzuochengshi
        cell.jiesuanfangshi.text = Gongzuoxinxidata![indexPath.item].jiesuanfangshi
        cell.jiesuanfangshi.text = Gongzuoxinxidata![indexPath.item].jiesuanfangshi
        //       let imageurl = JobOffersdata![indexPath.item].AvatarImage
        //            //        //定义URL对象
        //            //        let url = URL(string: "\(imageurl)")
        //            //        print(url)
        //            //        //        cell.AvatarImage.af_setImage(withURL: url!, placeholderImage: placeholderImage)
        
        
        cell.backgroundColor = UIColor.white
        
        return cell
    }
    
}


// MARK:- 设置UI界面内容
extension RecommendViewController {
    
    func setrupUI(){
        contentView = collectionView
        
        view.addSubview(collectionView)
        collectionView.addSubview(animImageView)
        //        collectionView.addSubview(pageTitleView)
        collectionView.backgroundColor = UIColor.white
        // 1.先调用super.setupUI()
        super.setupUI()
        
        
    }
}
//Mark  请求数据
extension RecommendViewController{
    func loadData(city:String){
        recommendMV.city = city
        recommendMV.requestgognzuoxinxiData{
            DispatchQueue.main.async {
                    print("第二次")
                self.collectionView.reloadData()
                self.loadDataFinished()
                print("回到主线程：\(Thread.current)")
            }
            
        }
    }
}
//Mark  遵守代理协议
extension RecommendViewController: UICollectionViewDelegate{
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        let xiangVc = XiangViewController()
    //        xiangVc.streing = JobOffersdata![indexPath.item].jobRequirements
    //        xiangVc.Jobid = JobOffersdata![indexPath.item].id
    //        if JobOffersdata![indexPath.item].Delivery == true {
    //            xiangVc.Deliverybtn.setTitle("已投递", for: .normal)
    //            xiangVc.Deliverybtn.isHighlighted = false
    //            xiangVc.Deliverybtn.backgroundColor = UIColor(r: 245, g: 245, b: 245)
    //        }else{
    //            xiangVc.Deliverybtn.setTitle("立即投递", for: .normal)
    //            xiangVc.Deliverybtn.isHighlighted = true
    //            xiangVc.Deliverybtn.backgroundColor = UIColor.green
    //        }
    //
    //
    //        navigationController?.pushViewController(xiangVc, animated: true)
    //
    //        collectionView.deselectItem(at: indexPath, animated: true)
    //
    //    }
}
// MARK:- 遵守PageTitleViewDelegate协议
extension RecommendViewController : PageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        //           pageContentView.setCurrentIndex(index)
        if index == 1 {
            let info = ["name":"date"] as [String : Any]
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "XMNotification"), object: "cityjob", userInfo: info)
        }else{
            let info = ["name":"tuijian"] as [String : Any]
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "XMNotification"), object: "cityjob", userInfo: info)
        }
        
        
    }
}

extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    
}
//金刚区菜单
extension RecommendViewController{
    
    func setrupjingangquUI() {
        jingangquview.frame = CGRect(x:0, y:  animImageView.frame.height+20, width: kScreenW, height: 100)
        jingangquview.backgroundColor = UIColor.white
        jingangquview.buttomBorder(width: 10, borderColor: UIColor(r: 245, g: 245, b: 245))
        collectionView.addSubview(jingangquview)
        //布局金刚区菜单图标
        setruptubiaoUI()
        jingangquview.addSubview(rezhaojianzhibtn)
        jingangquview.addSubview(zuixinjianzhibtn)
        jingangquview.addSubview(dengtarenwubtn)
        jingangquview.addSubview(dengtazixunbtn)
        
    }
    
    //金刚区菜单图标
    func setruptubiaoUI() {
        //热招兼职
        rezhaojianzhibtn.frame = CGRect(x:0, y:-10, width: jingangquview.frame.width/4, height: 74)
        rezhaojianzhibtn.titleLabel?.font = UIFont.systemFont(ofSize: 11) //文字大小
        rezhaojianzhibtn.setTitleColor(UIColor(r: 48, g: 48,b: 48), for: UIControl.State.normal) //文字颜色
        rezhaojianzhibtn.set(image: UIImage(named: "guanyuwomen"), title: "热招兼职", titlePosition: .bottom,
                             additionalSpacing: 20, state: .normal)
        rezhaojianzhibtn.addTarget(self, action: #selector(RecommendViewController.rezhaojianzhibtnClick(sender:)), for: .touchUpInside)
        
        //最新兼职
        zuixinjianzhibtn.frame = CGRect(x:jingangquview.frame.width/4, y:-10, width: jingangquview.frame.width/4, height: 74)
        zuixinjianzhibtn.titleLabel?.font = UIFont.systemFont(ofSize: 11) //文字大小
        zuixinjianzhibtn.setTitleColor(UIColor(r: 48, g: 48,b: 48), for: UIControl.State.normal) //文字颜色
        zuixinjianzhibtn.set(image: UIImage(named: "shezhi"), title: "最新兼职", titlePosition: .bottom,
                             additionalSpacing: 20, state: .normal)
        zuixinjianzhibtn.addTarget(self, action: #selector(RecommendViewController.zuixinjianzhibtnClick(sender:)), for: .touchUpInside)
        //灯塔任务
        dengtarenwubtn.frame = CGRect(x:jingangquview.frame.width*2/4, y:-10, width: jingangquview.frame.width/4, height: 74)
        dengtarenwubtn.titleLabel?.font = UIFont.systemFont(ofSize: 11) //文字大小
        dengtarenwubtn.setTitleColor(UIColor(r: 48, g: 48,b: 48), for: UIControl.State.normal) //文字颜色
        dengtarenwubtn.set(image: UIImage(named: "shezhi"), title: "灯塔任务", titlePosition: .bottom,
                           additionalSpacing: 20, state: .normal)
        dengtarenwubtn.addTarget(self, action: #selector(RecommendViewController.dengtarenwubtnClick(sender:)), for: .touchUpInside)
        //灯塔资讯
        dengtazixunbtn.frame = CGRect(x:jingangquview.frame.width*3/4, y:-10, width: jingangquview.frame.width/4, height: 74)
        dengtazixunbtn.titleLabel?.font = UIFont.systemFont(ofSize: 11) //文字大小
        dengtazixunbtn.setTitleColor(UIColor(r: 48, g: 48,b: 48), for: UIControl.State.normal) //文字颜色
        dengtazixunbtn.set(image: UIImage(named: "shezhi"), title: "灯塔资讯", titlePosition: .bottom,
                           additionalSpacing: 20, state: .normal)
        dengtazixunbtn.addTarget(self, action: #selector(RecommendViewController.dengtazixunbtnClick(sender:)), for: .touchUpInside)
        
        
    }
    //金刚区点击事件
    @objc func rezhaojianzhibtnClick(sender: UIButton) {
        print(1)
    }
    @objc func zuixinjianzhibtnClick(sender: UIButton) {
        print(2)
    }
    @objc func dengtarenwubtnClick(sender: UIButton) {
        print(3)
    }
    @objc func dengtazixunbtnClick(sender: UIButton) {
        print(4)
    }
}
