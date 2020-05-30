//
//  CustomBtn.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/5/30.
//  Copyright © 2020 殷义军. All rights reserved.
//


import UIKit

class CustomBtn: UIButton {


    //MARK:- 重写init函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(UIImage(named:"navigationbar_arrow_up"), for: .normal)
        setImage(UIImage(named:"navigationbar_arrow_down"), for: .selected)
        setTitleColor(UIColor(r: 48, g: 4, b: 48), for: .normal)
        
        backgroundColor = UIColor(hue: 46, saturation: 46, brightness: 46, alpha: 0)
        
        
    }
    
    //swift中规定:重写控件的init(frame方法)或者init()方法.必须重写 init?(coder aDecoder: NSCoder)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //titleLabel ,imageView中间的空隙宽度
        let spaceWid = CGFloat(5)
        //btn的宽度
        let btnWid = frame.size.width
        //titleLabel ,imageView的总宽度 加 空隙
        let wid = titleLabel!.frame.size.width + imageView!.frame.size.width + spaceWid
        
//        titleLabel!.frame.origin.x = 0
        imageView!.frame.origin.x = titleLabel!.frame.maxX + spaceWid
        
    }

}

