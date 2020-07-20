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

extension UIButton {
 
    @objc func set(image anImage: UIImage?, title: String,
                   titlePosition: UIView.ContentMode, additionalSpacing: CGFloat, state: UIControl.State){
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)
         
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
         
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
    }
     
    private func positionLabelRespectToImage(title: String, position: UIView.ContentMode,
        spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont!])
         
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
         
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),
                left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing),
                left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                right: -(titleSize.width * 2 + spacing))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
         
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}
