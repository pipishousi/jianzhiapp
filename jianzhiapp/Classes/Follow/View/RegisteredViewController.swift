//
//  RegisteredViewController.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/5/30.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit

class RegisteredViewController: UIViewController, UITextFieldDelegate {
    lazy var LigonBtn : CustomBtn = CustomBtn()
        lazy var RegisteredBtn : CustomBtn = CustomBtn()
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
        var showType:RegisteredShowType = RegisteredShowType.NONE
        
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
             navigationController?.setNavigationBarHidden(true, animated: true)
         }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }


}
//布局界面
extension RegisteredViewController{
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
            dismiss(animated: true, completion:nil)
        // 顯示提示框
        self.present(
          alertController,
          animated: true,
          completion: nil)
    }
    func LayoutUI(){
        self.view.backgroundColor = UIColor(r: 255, g: 213, b: 70)
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
        LigonBtn.setTitle("注册", for: .normal)
        LigonBtn.frame = CGRect(x: 30, y: 200, width: vLogin.frame.size.width - 60, height: 44)
        LigonBtn.addTarget(self, action: #selector(RegisteredViewController.RegisteredClick(sender:)), for: .touchUpInside)
        LigonBtn.titleLabel!.center = view.center
        LigonBtn.backgroundColor = UIColor.white
        LigonBtn.layer.cornerRadius = 8
        vLogin.addSubview(LigonBtn)
        //注册按钮
        RegisteredBtn.setTitle("我已有账号, 去登录", for:.normal)
        RegisteredBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        RegisteredBtn.frame = CGRect(x: 20, y: 134, width: 100, height: 44)
        RegisteredBtn.setTitleColor(UIColor.lightGray, for: .normal)
        RegisteredBtn.addTarget(self, action: #selector(RegisteredViewController.ligon(sender:)), for: .touchUpInside)
        vLogin.addSubview(RegisteredBtn)
        //密码输入框左侧图标
        let imgPwd =  UIImageView(frame:CGRect(x: 11, y: 11, width: 22, height: 22))
        imgPwd.image = UIImage(named:"iconfont-password")
        txtPwd.leftView!.addSubview(imgPwd)
        vLogin.addSubview(txtPwd)
    }
}
//猫头鹰动画实现
extension RegisteredViewController{
    func  Maotouyin() {
        //输入框获取焦点开始编辑
         func textFieldDidBeginEditing(textField:UITextField)
        {
            //如果当前是用户名输入
            if textField.isEqual(txtUser){
                if (showType != RegisteredShowType.PASS)
                {
                    showType = RegisteredShowType.USER
                    return
                }
                showType = RegisteredShowType.USER
                
                
            }
                //如果当前是密码名输入
            else if textField.isEqual(txtPwd){
                if (showType == RegisteredShowType.PASS)
                {
                    showType = RegisteredShowType.PASS
                    return
                }
                showType = RegisteredShowType.PASS
                
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
extension RegisteredViewController{
    //注册
    @objc func RegisteredClick(sender:UIButton){
       print("我点击了注册")
        RegisteredVerification()
        
    }
    //返回登录页面
    @objc func ligon(sender:UIButton){
          print("我点击了登录")
        self.dismiss(animated: true, completion: nil)

//        self.navigationController?.popViewController(animated: true)
       
    }
    //将注册信息上传到服务器
    func RegisteredVerification() {
        
        let username = txtUser.text
        let password = txtPwd.text
        if username == "" {
            self.simpleHint(message: "亲！您还没有输入账号哦")
        }else{
            if password == ""{
                self.simpleHint(message: "亲！您还没有输入密码哦")
            }else{
                let user = BmobUser()
                user.username = username
                user.password = password
                user.signUpInBackground { (isSuccessful, error) in
                    if isSuccessful {
                        
                        self.simpleHint(message: "亲！恭喜您注册成功")
                    }else{
                        print("Sign up error\(error)")
                    }
                }
            }
        }
    }
}
//登录框状态枚举
enum RegisteredShowType {
    case NONE
    case USER
    case PASS
}
