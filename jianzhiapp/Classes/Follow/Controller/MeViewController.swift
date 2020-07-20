//
//  MeViewController.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/5/26.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit
import RealmSwift
import AlamofireImage
private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90
private let kItemW : CGFloat = 90
private let kItemH : CGFloat = 60
private let KMeCellID = "KMeCellID"
private let KGRCellID = "KGRCellID"
private let OUTID = "OUTID"
private let kTitleViewH : CGFloat = 40
class MeViewController: UIViewController {
    lazy var btn : CustomBtn = CustomBtn()
    let btn1:UIButton = UIButton()
    
    var touxiangimageView = UIImageView(image: UIImage(named: "touxiang2"))
    let uilabelcygn = UILabel()
    lazy var xiaoxibtn :UIButton = UIButton()
    lazy var daigoutongbtn :UIButton = UIButton()
    lazy var yitoudibtn : UIButton = UIButton()
    lazy var btn2 :UIButton = UIButton()
    lazy var btn4 :UIButton = UIButton()
    lazy var btn3 : UIButton = UIButton()
    lazy var tuichubtn : CustomBtn = CustomBtn()
    var  userzhanghao :Results<User>?
    // 获取默认的 Realm 数据库
    let realm = try! Realm()
    //自定义菜单栏
    fileprivate lazy var changyonggn : UIView = {
        let changyonggn = UIView()
        changyonggn.backgroundColor = UIColor.white
        return changyonggn
    }()
    
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
        collectionMeView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: OUTID)
        return collectionMeView
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = BmobUser.getCurrent()
        if user != nil {
            tuichubtn.setTitle( "退出登录", for: .normal)
            tuichubtn.backgroundColor = UIColor(r: 255, g: 223, b: 70)
            tuichubtn.isEnabled = true
        }else{
            touxiangimageView.image = UIImage(named: "touxiang2")
            tuichubtn.setTitle( " ", for: .normal)
            tuichubtn.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
            tuichubtn.isEnabled = false
        }
        //
        //        print(user!.object(forKey: "touxiangImage") as? String)
        //更新头像集名称信息
        updatatouxiangmingzi()
        userzhanghao = realm.objects(User.self)
        
        setupUI()
    }
    
    
}

// MARK:- 设置UI界面内容
extension MeViewController {
    func updatatouxiangmingzi() {
        let user = BmobUser.getCurrent()
        if user != nil {
            let query:BmobQuery = BmobQuery(className: "_User")
            query.getObjectInBackground(withId: user!.objectId!) { (obj, error) in
                if error != nil {
                    //进行错误处理
                }else{
                    let userdata = obj as! BmobUser
                    //对象为空时，可打开用户注册界面
                    if userdata.object(forKey: "name") as? String != nil {
                        self.btn.setTitle( (userdata.object(forKey: "name") as? String)! , for: .normal)
                        
                    }else{
                        self.btn.setTitle( (userdata.object(forKey: "username") as? String)! , for: .normal)
                        
                    }
                    if userdata.object(forKey: "touxiangImage") as? String != nil {
                        let placeholderImage = UIImage(named: "touxiang4")!
                        let url = URL(string: (userdata.object(forKey: "touxiangImage") as? String)!)
                        self.touxiangimageView.af_setImage(withURL: url!, placeholderImage: placeholderImage)
                    }else{
                        self.touxiangimageView.image = UIImage(named: "touxiang4")!
                        
                    }
                }
                
            }
            
        }else{
            //对象为空时，可打开用户注册界面
            btn.setTitle( "登录", for: .normal)
        }
    }
    private func setupUI(){
        
        view.addSubview(collectionMeView)
        navigationController?.navigationBar.barTintColor = UIColor(r: 255, g: 223, b: 70)
        //导航栏透明
        //        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        changyonggn.addSubview(uilabelcygn)
        changyonggn.addSubview(btn1)
        changyonggn.addSubview(btn2)
        changyonggn.addSubview(btn3)
        
        
    }
}

// MARK:- 遵守协议
extension MeViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item ==  0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KGRCellID, for: indexPath) as! CollectionGRViewCell
            
            cell.addSubview(touxiangimageView)
            setupgrzx(cell:cell.kuaijiecaidan.frame.width)
            cell.kuaijiecaidan.addSubview(xiaoxibtn)
            cell.kuaijiecaidan.addSubview(daigoutongbtn)
            cell.kuaijiecaidan.addSubview(yitoudibtn)
            cell.addSubview(btn)
            
            
            return cell
        }
        if indexPath.item ==  3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OUTID,  for: indexPath)
            cell.addSubview(tuichubtn)
            return cell
        }
        if indexPath.item ==  1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KMeCellID, for: indexPath) as! CollectionMeCell
            
            cell.addSubview(changyonggn)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OUTID,  for: indexPath)
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
        if indexPath.item == 3 {
            return CGSize(width: kScreenW, height: 50)
        }
        if indexPath.item == 1 {
            return CGSize(width: kScreenW, height:142)
        }
        return CGSize(width: kScreenW, height:50)
    }
}


//MARK:- 事件监听
extension MeViewController: LigonMeDelegate,TouxiangImageDelegate{
    func nameData(name: String) {
        btn.setTitle( name, for: .normal)
    }
    
    
    
    
    func TouxiangImageData(touxiangImage: String) {
        let url = URL(string: touxiangImage)
        self.touxiangimageView.af_setImage(withURL: url!)
    }
    
    func LigonusernameData(username: String) {
        print(username)
        btn.setTitle(username, for: .normal)
        tuichubtn.setTitle( "退出登录", for: .normal)
        tuichubtn.backgroundColor = UIColor(r: 255, g: 223, b: 70)
        tuichubtn.isEnabled = true
    }
    
    
    @objc func btnClick(sender:UIButton) {
        let user = BmobUser.getCurrent()
        if user != nil {
            
        }else{
            sender.isSelected = !sender.isSelected
            let login = LigonViewController()
            login.delegate = self
            self.navigationController?.present(login, animated: true, completion: nil)
        }
        
        //        self.navigationController?.pushViewController(login, animated: true)
    }
    
}
//布局个人中心菜单
extension MeViewController{
    func setupgrzx(cell: CGFloat){
        //头像
        touxiangimageView.frame = CGRect(x: 20, y: 20, width: 78, height: 78)
        touxiangimageView.layer.masksToBounds = true
        touxiangimageView.layer.cornerRadius = 39
        //常用功能标题
        uilabelcygn.text = "常用功能"
        uilabelcygn.textColor = UIColor(r: 48, g: 48, b: 48)
        uilabelcygn.font = UIFont.systemFont(ofSize: 20)
        uilabelcygn.frame = CGRect(x: 15, y: 15, width: 200, height: 30)
        //按钮样式
        btn.frame = CGRect(x: 112, y: 34, width: 180, height: 50)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        btn.contentHorizontalAlignment = .left
        //        btn.textLabel.textAlignment = UITextAlignmentLeft
        
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        //常用功能背景块
        changyonggn.frame = CGRect(x: 15, y: 0, width: (kScreenW-30), height: 142)
        changyonggn.layer.cornerRadius = 6
        
        //关于我们
        btn1.frame = CGRect(x:0, y:40, width: changyonggn.frame.width/3, height: 68)
        btn1.titleLabel?.font = UIFont.systemFont(ofSize: 11) //文字大小
        btn1.setTitleColor(UIColor(r: 48, g: 48,b: 48), for: UIControl.State.normal) //文字颜色
        btn1.set(image: UIImage(named: "guanyuwomen"), title: "关于我们", titlePosition: .bottom,
                 additionalSpacing: 20, state: .normal)
        btn1.addTarget(self, action: #selector(MeViewController.guanyuwomenClick(sender:)), for: .touchUpInside)
        
        //版本信息
        btn2.frame = CGRect(x:changyonggn.frame.width/3, y:40, width: changyonggn.frame.width/3, height: 68)
        btn2.titleLabel?.font = UIFont.systemFont(ofSize: 11) //文字大小
        btn2.setTitleColor(UIColor(r: 48, g: 48,b: 48), for: UIControl.State.normal) //文字颜色
        btn2.set(image: UIImage(named: "shezhi"), title: "设置", titlePosition: .bottom,
                 additionalSpacing: 20, state: .normal)
        btn2.addTarget(self, action: #selector(MeViewController.shezhiClick(sender:)), for: .touchUpInside)
        
        
        //快捷菜单
        xiaoxibtn.frame = CGRect(x: 15, y:0 , width: (self.view.frame.width - 30)*1/3 , height: 46)
        xiaoxibtn.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        xiaoxibtn.setTitleColor(UIColor(r: 48, g: 48,b: 48), for: UIControl.State.normal) //文字颜色
        xiaoxibtn.set(image: UIImage(named: "xiaoxi"), title: "消息", titlePosition: .bottom,
                      additionalSpacing: 5.0, state: .normal)
        xiaoxibtn.addTarget(self, action: #selector(MeViewController.xiaoxibtnClick(sender:)), for: .touchUpInside)
        
        daigoutongbtn.frame = CGRect(x: (self.view.frame.width - 30)*1/3, y:0 , width: (self.view.frame.width - 30)*1/3 , height: 46)
        daigoutongbtn.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        daigoutongbtn.setTitleColor(UIColor(r: 48, g: 48,b: 48), for: UIControl.State.normal) //文字颜色
        daigoutongbtn.set(image: UIImage(named: "toudi"), title: "已投递", titlePosition: .bottom,
                          additionalSpacing: 5.0, state: .normal)
        daigoutongbtn.addTarget(self, action: #selector(MeViewController.daigoutongbtnClick(sender:)), for: .touchUpInside)
        
        
        yitoudibtn.frame = CGRect(x: ((self.view.frame.width - 30)/3)*2 - 15, y:0 , width: (self.view.frame.width - 30)*1/3 , height: 46)
        yitoudibtn.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        yitoudibtn.setTitleColor(UIColor(r: 48, g: 48,b: 48), for: UIControl.State.normal) //文字颜色
        yitoudibtn.set(image: UIImage(named: "shoucang"), title: "收藏", titlePosition: .bottom,
                       additionalSpacing: 5.0, state: .normal)
        yitoudibtn.addTarget(self, action: #selector(MeViewController.yitoudibtnClick(sender:)), for: .touchUpInside)
        
        tuichubtn.frame = CGRect(x: 15, y:0 , width: (self.view.frame.width - 30) , height: 46)
        tuichubtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        tuichubtn.setTitleColor(UIColor(r: 48, g: 48,b: 48), for: UIControl.State.normal) //文字颜色
        
        tuichubtn.layer.cornerRadius = 5
        tuichubtn.layer.masksToBounds = true
        tuichubtn.addTarget(self, action: #selector(MeViewController.tuichubtnClick(sender:)), for: .touchUpInside)
    }
}
//点击事件
extension MeViewController{
    //推出账号
    @objc func tuichubtnClick(sender: UIButton) {
        BmobUser.logout()
        btn.setTitle( "登录", for: .normal)
        touxiangimageView.image = UIImage(named: "touxiang2")
        tuichubtn.setTitle( " ", for: .normal)
        tuichubtn.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
        tuichubtn.isEnabled = false
    }
    //跳转消息页面
    @objc func xiaoxibtnClick(sender: UIButton) {
        let xiaoxibtnVc = XiaoXiViewController()
        navigationController?.pushViewController(xiaoxibtnVc, animated: true)
        
        
    }
    //跳转已投递页面
    @objc func daigoutongbtnClick(sender: UIButton) {
        let user = BmobUser.getCurrent()
        if user != nil {
            let daigoutongbtnVc = YiTouDiViewController()
            navigationController?.pushViewController(daigoutongbtnVc, animated: true)
        }else{
            loginClick()
        }
        
    }
    
    //跳转收藏页面
    @objc func yitoudibtnClick(sender: UIButton) {
        let user = BmobUser.getCurrent()
        if user != nil {
            let yitoudibtnVc = ShouCangViewController()
            navigationController?.pushViewController(yitoudibtnVc, animated: true)
        }else{
            loginClick()
        }
        
    }
    
    //关于我们
    @objc func guanyuwomenClick(sender: UIButton) {
        let guanyuwomenVc = GuanYuWoMenViewController()
        navigationController?.pushViewController(guanyuwomenVc, animated: true)
    }
    
    //设置
    @objc func shezhiClick(sender: UIButton) {
        let user = BmobUser.getCurrent()
        if user != nil {
            let shezhiVc = SheZhiViewController()
            shezhiVc.delegate = self
            navigationController?.pushViewController(shezhiVc, animated: true)
        }else{
            loginClick()
        }
        
    }
    func loginClick() {
        let login = LigonViewController()
        self.navigationController?.present(login, animated: true, completion: nil)
        //        self.navigationController?.pushViewController(login, animated: true)
    }
}
