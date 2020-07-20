//
//  WechatnumberViewController.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/6/5.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit
protocol wechatnumberDeleget{
    func wechatnumberData(weahatnumber:String)
}
class WechatnumberViewController: UIViewController {
    let textField = UITextField( )
    let fengexianview = UIView()
    lazy var btnss : CustomBtn = CustomBtn()
    var delegate: wechatnumberDeleget?
    override func viewDidLoad() {
        super.viewDidLoad()
        //分割线
        fengexianview.frame = CGRect(x: 20, y: 54, width: view.frame.width - 40, height: 1)
        fengexianview.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        textField.frame = CGRect(x:20, y:16, width: view.frame.width - 40, height:42)
         //设置边框样式为圆角矩形
//        textField.borderStyle = UITextField.BorderStyle.roundedRect
           self.view.addSubview(textField)
         self.view.addSubview(fengexianview)
        textField.font  = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 0))
        textField.textColor = UIColor(r: 48, g: 48, b: 48)
//        textField.placeholder="请输入用户名"
//        textField.text = "请输入用户名"
        view.backgroundColor = UIColor.white
        
        //按钮样式
//        btnss.frame = CGRect(x: 112, y: 34, width: 100, height: 50)
        btnss.setTitle("确定", for: .normal)
        btnss.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        //        btn.center = view.center
        btnss.addTarget(self, action: #selector(WechatnumberViewController.btnClick(sender:)), for: .touchUpInside)
        let navgetcolloeritem = UIBarButtonItem(customView: btnss)
        navigationItem.rightBarButtonItem = navgetcolloeritem
        navigationItem.leftBarButtonItem?.title = "dada "
        
    }
    @objc func btnClick(sender: UIButton) {
        let user = BmobUser.getCurrent()
        user!.setObject(textField.text!, forKey: "wechatnumber")
        user!.updateInBackground { (isSuccessful, error) in
        }
        delegate?.wechatnumberData(weahatnumber: textField.text!)
        navigationController?.popViewController(animated: true)
    }
}
