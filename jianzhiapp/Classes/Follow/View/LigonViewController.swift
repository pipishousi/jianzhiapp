//
//  LigonViewController.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/5/29.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit
import RealmSwift
protocol LigonMeDelegate {
    func LigonusernameData(username: String)
}
class LigonViewController: UIViewController, UITextFieldDelegate{
    var delegate: LigonMeDelegate?
    var userjob: Results<User>?
    
    // 获取默认的 Realm 数据库
    let realm = try! Realm()
    let myDog = User()
    lazy var txtBtnLigon : CustomBtn = CustomBtn()
    lazy var txtBtnRegistered : CustomBtn = CustomBtn()
    //获取屏幕尺寸
    let mainSize = UIScreen.main.bounds.size
    //用户密码输入框
    var txtUser:UITextField!
    var txtPwd:UITextField!
    //左手离脑袋的距离
    var offsetLeftHand:CGFloat = 60
    //左手图片,右手图片(遮眼睛的)
    var imgLeftHand:UIImageView!
    var imgRightHand:UIImageView!
    //左手图片,右手图片(圆形的)
    var imgLeftHandGone:UIImageView!
    var imgRightHandGone:UIImageView!
    
    //登录框状态
    var showType:LoginShowType = LoginShowType.NONE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //布局UI界面
        
        LayoutUI()
        //猫头鹰动画实现
        Maotouyin()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //页面显示时隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //页面离开时显示导航栏
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //
}

//布局界面
extension LigonViewController{
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
    
    //布局UI界面
    func LayoutUI(){
        //猫头鹰头部
        let imgLogin =  UIImageView(frame:CGRect(x: mainSize.width/2-211/2, y: 100, width: 211, height: 109))
        imgLogin.image = UIImage(named:"owl-login")
        imgLogin.layer.masksToBounds = true
        self.view.addSubview(imgLogin)
        
        //猫头鹰左手(遮眼睛的)
        let rectLeftHand = CGRect(x: 61 - offsetLeftHand, y: 90, width: 40, height: 65)
        imgLeftHand = UIImageView(frame:rectLeftHand)
        imgLeftHand.image = UIImage(named:"owl-login-arm-left")
        imgLogin.addSubview(imgLeftHand)
        
        //猫头鹰右手(遮眼睛的)
        let rectRightHand = CGRect(x: imgLogin.frame.size.width / 2 + 60, y: 90, width: 40, height: 65)
        imgRightHand = UIImageView(frame:rectRightHand)
        imgRightHand.image = UIImage(named:"owl-login-arm-right")
        imgLogin.addSubview(imgRightHand)
        
        //登录框背景
        let vLogin =  UIView(frame:CGRect(x: 15, y: 200, width: mainSize.width - 30, height: 400))
        vLogin.layer.borderWidth = 0
        vLogin.layer.borderColor = UIColor.lightGray.cgColor
        vLogin.backgroundColor = UIColor(hue: 255, saturation: 213, brightness: 70, alpha: 0.0)
        self.view.addSubview(vLogin)
        
        //猫头鹰左手(圆形的)
        let rectLeftHandGone = CGRect(x: mainSize.width / 2 - 100,
                                      y: vLogin.frame.origin.y - 22, width: 40, height: 40)
        imgLeftHandGone = UIImageView(frame:rectLeftHandGone)
        imgLeftHandGone.image = UIImage(named:"icon_hand")
        self.view.addSubview(imgLeftHandGone)
        
        //猫头鹰右手(圆形的)
        let rectRightHandGone = CGRect(x: mainSize.width / 2 + 62,
                                       y: vLogin.frame.origin.y - 22, width: 40, height: 40)
        imgRightHandGone = UIImageView(frame:rectRightHandGone)
        imgRightHandGone.image = UIImage(named:"icon_hand")
        self.view.addSubview(imgRightHandGone)
        
        //用户名输入框
        txtUser = UITextField(frame:CGRect(x: 30, y: 30, width: vLogin.frame.size.width - 60, height: 44))
        txtUser.delegate = self
        txtUser.layer.cornerRadius = 5
        txtUser.layer.borderColor = UIColor.lightGray.cgColor
        txtUser.layer.borderWidth = 0.5
        txtUser.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 44))
        txtUser.leftViewMode = UITextField.ViewMode.always
        
        //用户名输入框左侧图标
        let imgUser =  UIImageView(frame:CGRect(x: 11, y: 11, width: 22, height: 22))
        imgUser.image = UIImage(named:"iconfont-user")
        txtUser.leftView!.addSubview(imgUser)
        vLogin.addSubview(txtUser)
        
        //密码输入框
        txtPwd = UITextField(frame:CGRect(x: 30, y: 90, width: vLogin.frame.size.width - 60, height: 44))
        txtPwd.delegate = self
        txtPwd.layer.cornerRadius = 5
        txtPwd.layer.borderColor = UIColor.lightGray.cgColor
        txtPwd.layer.borderWidth = 0.5
        //        txtPwd.secureTextEntry = true
        txtPwd.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 44))
        txtPwd.leftViewMode = UITextField.ViewMode.always
        //登录按钮
        txtBtnLigon.setTitle("登录", for: .normal)
        txtBtnLigon.frame = CGRect(x: 30, y: 200, width: vLogin.frame.size.width - 60, height: 44)
        txtBtnLigon.addTarget(self, action: #selector(LigonViewController.ligonClick(sender:)), for: .touchUpInside)
        txtBtnLigon.titleLabel!.center = view.center
        txtBtnLigon.backgroundColor = UIColor.white
        txtBtnLigon.layer.cornerRadius = 8
        vLogin.addSubview(txtBtnLigon)
        //注册按钮
        txtBtnRegistered.setTitle("还没有账号", for:.normal)
        txtBtnRegistered.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        txtBtnRegistered.frame = CGRect(x: 20, y: 134, width: 100, height: 44)
        txtBtnRegistered.setTitleColor(UIColor.lightGray, for: .normal)
        
        txtBtnRegistered.addTarget(self, action: #selector(LigonViewController.Registered(sender:)), for: .touchUpInside)
        vLogin.addSubview(txtBtnRegistered)
        //密码输入框左侧图标
        let imgPwd =  UIImageView(frame:CGRect(x: 11, y: 11, width: 22, height: 22))
        imgPwd.image = UIImage(named:"iconfont-password")
        txtPwd.leftView!.addSubview(imgPwd)
        vLogin.addSubview(txtPwd)
    }
}
//猫头鹰动画实现
extension LigonViewController{
    func  Maotouyin() {
        //输入框获取焦点开始编辑
        func textFieldDidBeginEditing(textField:UITextField)
        {
            //如果当前是用户名输入
            if textField.isEqual(txtUser){
                if (showType != LoginShowType.PASS)
                {
                    showType = LoginShowType.USER
                    return
                }
                showType = LoginShowType.USER
                
                
            }
                //如果当前是密码名输入
            else if textField.isEqual(txtPwd){
                if (showType == LoginShowType.PASS)
                {
                    showType = LoginShowType.PASS
                    return
                }
                showType = LoginShowType.PASS
                
                //播放遮眼动画
                UIView.animate(withDuration: 0.5, animations: { () -> Void in
                    self.imgLeftHand.frame = CGRect(
                        x: self.imgLeftHand.frame.origin.x + self.offsetLeftHand,
                        y: self.imgLeftHand.frame.origin.y - 30,
                        width: self.imgLeftHand.frame.size.width, height: self.imgLeftHand.frame.size.height)
                    self.imgRightHand.frame = CGRect(
                        x: self.imgRightHand.frame.origin.x - 48,
                        y: self.imgRightHand.frame.origin.y - 30,
                        width: self.imgRightHand.frame.size.width, height: self.imgRightHand.frame.size.height)
                    self.imgLeftHandGone.frame = CGRect(
                        x: self.imgLeftHandGone.frame.origin.x + 70,
                        y: self.imgLeftHandGone.frame.origin.y, width: 0, height: 0)
                    self.imgRightHandGone.frame = CGRect(
                        x: self.imgRightHandGone.frame.origin.x - 30,
                        y: self.imgRightHandGone.frame.origin.y, width: 0, height: 0)
                })
            }
        }
    }
    
    
}
//登录事件
extension LigonViewController{
    //登录
    @objc func ligonClick(sender:UIButton){
        print("我点击了登录")
        //登录验证
         CBToast.showToastAction()
        ligonVerification()
        
    }
    //跳转注册页面
    @objc func Registered(sender:UIButton){
        
        // print("我点击了注册")
        let registered = RegisteredViewController()
        self.present(registered, animated: true, completion: nil)
        //        navigationController?.pushViewController(registered, animated: true)
        
    }
    //登录验证
    func ligonVerification() {
//        self.navigationController?.popViewController(animated: true)
        
        let username = txtUser.text
        let password = txtPwd.text
        if username == "" {
            self.simpleHint(message: "亲！您还没有输入账号哦")
        }else{
            if password == ""{
                self.simpleHint(message: "亲！您还没有输入密码哦")
            }else{
               
                //自己定义时间和位置
                BmobUser.loginInbackground(withAccount: username, andPassword: password) { (user, error) in
                    if user != nil {
                        //关闭
                        let users = user
                        self.saveuserData(username:users!)
                        
                    }else{
                        self.simpleHint(message: "账号或者密码错误")
                    }
                }
            }
        }
    }
    func saveuserData(username: BmobUser){
        //查找GameScore表
//        print(12342)
        let query:BmobQuery = BmobQuery(className: "_User")
        query.getObjectInBackground(withId: username.objectId!) { (obj, error) in
            if error != nil {
                //进行错误处理
            }else{
                if obj != nil{
                    if obj!.object(forKey: "name") as? String == nil {
                        self.delegate?.LigonusernameData(username: (obj!.object(forKey: "username") as? String)! )
                    }else{
                        self.delegate?.LigonusernameData(username: (obj!.object(forKey: "name") as? String)! )
                        
                    }
                    CBToast.hiddenToastAction()
                            self.dismiss(animated: true, completion: nil)

//                    self.myDog.username = (obj!.object(forKey: "username") as? String)!
//                    self.myDog.userID  = (obj!.object(forKey: "objectId") as? String)!
//                    self.myDog.id  = (obj!.object(forKey: "objectId") as? String)!
//                    self.myDog.myadvantage  = (obj!.object(forKey: "myadvantage") as? String)!
//                    self.myDog.wechatnumber  = (obj!.object(forKey: "wechatnumber") as? String)!
//                    self.myDog.name  = (obj!.object(forKey: "name") as? String)!
//                    self.myDog.gender  = (obj!.object(forKey: "gender") as? Bool)!
//                    // 数据存储十分简单
//                    try! self.self.realm.write {
//                        
//                        self.realm.add(self.myDog, update: .modified)
//                    }
                }
            }
        }
        
        
    }
    //登录框状态枚举
    enum LoginShowType {
        case NONE
        case USER
        case PASS
    }
    
}
