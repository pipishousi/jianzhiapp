//
//  usernameViewController.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/6/4.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit
protocol UsernameDeleget{
    func UsernameData(Username:String)
}

class UsernameViewController: UIViewController {
    let UsernametextField = UITextField( )
    lazy var btnss : CustomBtn = CustomBtn()
    let fengexianview = UIView()
    var delegate: UsernameDeleget?
    override func viewDidLoad() {
        super.viewDidLoad()
        //分割线
        fengexianview.frame = CGRect(x: 20, y: 54, width: view.frame.width - 40, height: 1)
        fengexianview.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        UsernametextField.frame = CGRect(x:20, y:16, width: view.frame.width - 40, height:42)
        //设置边框样式为圆角矩形
        //            UsernametextField.borderStyle = UITextField.BorderStyle.roundedRect
        
        
        UsernametextField.font  = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 0))
        UsernametextField.textColor = UIColor(r: 48, g: 48, b: 48)
        //        textField.placeholder="请输入用户名"
        //        textField.text = "请输入用户名"
        view.backgroundColor = UIColor.white
        
        //按钮样式
        //        btnss.frame = CGRect(x: 112, y: 34, width: 100, height: 50)
        btnss.setTitle("确定", for: .normal)
        btnss.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        //        btn.center = view.center
        btnss.addTarget(self, action: #selector(UsernameViewController.btnClick(sender:)), for: .touchUpInside)
        let navgetcolloeritem = UIBarButtonItem(customView: btnss)
        navigationItem.rightBarButtonItem = navgetcolloeritem
        navigationItem.leftBarButtonItem?.title = "dada "
        self.view.addSubview(UsernametextField)
        self.view.addSubview(fengexianview)
        
    }
    @objc func btnClick(sender: UIButton) {
        let user = BmobUser.getCurrent()
        //进行操作
        //                        self.recommendMV.updatatouxiangmingzi()
        user!.setObject(UsernametextField.text!, forKey: "name")
        user!.updateInBackground { (isSuccessful, error) in
        }
        delegate?.UsernameData(Username: UsernametextField.text!)
        navigationController?.popViewController(animated: true)
    }
}
