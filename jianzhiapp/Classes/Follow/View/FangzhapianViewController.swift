//
//  FangzhapianViewController.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/7/7.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit
private let kTitleViewH : CGFloat = 40
class FangzhapianViewController: UIViewController, UITextViewDelegate {
    //图文混排显示的文本区域
    //        @IBOutlet weak var textView: UITextView!
    let xiang = Common()
    var textView = UITextView()
    let attributedStr = NSMutableAttributedString(
        string: "",
        attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.green
        ]
    )
    override func viewDidLoad() {
        super.viewDidLoad()
        //文字大小
        self.title = "防骗指南"
        textView.isEditable = false
        view.backgroundColor = UIColor.white
        self.view.addSubview(textView)
        //设置textview里面的字体颜色
        textView.textColor = UIColor.green
//        self.textView.textContainer.lineFragmentPadding = 15
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 100, right: 15)
        let regularAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]

        let largeAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]
        textView.delegate = self
        textView.frame = CGRect(x:0, y:0, width:view.frame.width, height:kScreenH)
        
        
        //初始化显示默认内容
        ////        insertString(text:"防骗指南\n",textfont: UIFont.systemFont(ofSize: 22))
        insertString(text:"一、传销陷阱：\n\n",textfont:CGFloat(20))
        
        insertString(text:"传销是指组织者发展人员，利用洗脑、控制人身自由、威逼、利诱、胁迫或诱导他人以“拉人头”、“发展下级”等方式，骗取财物，获得财富的违法行为。毕业生和刚工作一年左右的求职者缺乏经验，往往是传销组织的首要欺骗对象，\n",textfont:CGFloat(16))
        
        insertString(text:"不法分子常常利用大家急于找工作的心态，进行诈骗。传销骗局示例：\n缺乏经验，往往是传销组织的首要欺骗对象，不法分子常常利用大家急于找工作的心态，进行诈骗。\n\n传销骗局示例",textfont:CGFloat(16))
        insertPicture(UIImage(named: "10615")!, mode:.fitTextLine)
        
        insertPicture(UIImage(named: "10616")!, mode:.fitTextLine)
        insertPicture(UIImage(named: "10614")!, mode:.fitTextLine)
        
        insertString(text:" 传销类虚假招聘的特征：\n\n1.面试实习一体化，要求直接带行李；\n2.面试地点在异地或偏僻郊区；\n3.不招本地人，询问当地是否有熟人；\n4.过分打听家庭状况，需要单独去面试；\n5.没有明确面试地址，约定某地派人去接；\n 6.不讨论公司业务，不考察专业技能；\n 7.传销高发地点：北京周边，天津静海、武清，河北廊坊、沧州，湖北襄阳，广西北海、来宾等；\n\nB灯塔兼职处理措施：\n\n求职者一旦遇到传销类招聘陷阱，请务必保持高度警惕，立即向平台举报。举报时，务必提交相关的、充分的证据（上传图片）。接到举报后，灯塔兼职会做如下处理：\n 1.实时向举报人反馈受理及处理情况；\n3.追查其所在公司，禁止其整个公司继续使用BOSS直聘；\n4.排查其他关联的Boss和企业，处理高危对象；\n 5.收集被举报者特征，完善反传销模型。感谢您对BOSS直聘的支持，祝您平安求职！\n\n",textfont: CGFloat(16))
        insertString(text:"二、招生陷阱\n\n ",textfont: CGFloat(20))
        insertString(text:"求职者所面对的招生骗局与学生求学所面临的招生骗局不同，很多培训机构以招聘为名，以高薪、名企工作岗位为饵，诱导求职者交钱参加培训，而求职者接受培训以后，对方却根本不会提供长期稳定的可靠工作。招生骗局示例： ",textfont: CGFloat(16))
        
        insertPicture(UIImage(named: "10617")!, mode:.fitTextLine)
        insertPicture(UIImage(named: "10618")!, mode:.fitTextLine)
        insertPicture(UIImage(named: "10619")!, mode:.fitTextLine)
        insertString(text:"建议：若已发生被骗事实，请向警方报案，灯塔兼职会积极配合取证调查，协助警方抓获犯罪分子。感谢您对灯塔兼职的支持，祝您平安求职！",textfont: CGFloat(18))
        attributedStr.setAttributes(largeAttributes, range: NSRange(location: 0, length: 8))
        attributedStr.setAttributes(regularAttributes, range: NSRange(location: 9, length: 189))
        attributedStr.setAttributes(regularAttributes, range: NSRange(location: 201, length: 380))
        attributedStr.setAttributes(largeAttributes, range: NSRange(location: 581, length: 8))
        attributedStr.setAttributes(regularAttributes, range: NSRange(location: 589, length: 102))
        attributedStr.setAttributes(regularAttributes, range: NSRange(location: 695, length: 63))


//        attributedStr.setAttributes(regularAttributes, range: NSRange(location: 587, length: 751))
        

        textView.attributedText = attributedStr
        print(textView.text.count)
        
    }
    //插入文字
    func insertString(text:String,textfont:CGFloat) {
        print(text.count)
        let attributedStra = NSMutableAttributedString(
            string: text,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: textfont, weight: UIFont.Weight(rawValue: 10)),
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
        )

        attributedStr.append(attributedStra)
        
    }
    
    //    插入图片
    func insertPicture(_ image:UIImage, mode:ImageAttachmentMode = .default){
        
        //创建图片附件
        let imgAttachment = NSTextAttachment(data: nil, ofType: nil)
        imgAttachment.image = image
        
        //设置图片显示方式
        //撑满一行
        let imageWidth = textView.frame.width - 30
        let imageHeight = image.size.height/image.size.width*imageWidth
        imgAttachment.bounds = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        let imageStr = NSAttributedString(
            attachment: imgAttachment
        )
        attributedStr.append(imageStr)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.contentOffset = .zero
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//插入的图片附件的尺寸样式
enum ImageAttachmentMode {
    case `default`  //默认（不改变大小）
    case fitTextLine  //使尺寸适应行高
    case fitTextView  //使尺寸适应textView
}
