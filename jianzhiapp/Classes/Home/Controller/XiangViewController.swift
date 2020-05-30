//
//  XiangViewController.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/5/24.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit
private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90
private let kItemW : CGFloat = 90
private let kItemH : CGFloat = kScreenW*1/3
private let KXiangCellID = "KXiangCellID"

class XiangViewController: UIViewController{

   var streing:String?

    let xiang = Common()
    
    // MARK:- 懒加载属性
    private lazy var xiangqingView : UICollectionView = {[unowned self] in
        //1、创建布局
        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width:kScreenW, height: 600)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        //2、创建collectionView
        let xiangqingView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
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
                xiang.KXinagH = getLabelTextHeight(font: UIFont.systemFont(ofSize: 16), width: kScreenW-30)(streing)
        setupUI()
        
    }

    
    
}
extension XiangViewController{
    
    private func setupUI(){
//        print(test(45))
           view.addSubview(xiangqingView)
//             KXinagH = 1000
          }
}
extension XiangViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = xiangqingView.dequeueReusableCell(withReuseIdentifier: KXiangCellID, for: indexPath) as! CollectionXinagCell
//        cell.backgroundColor = UIColor.red
        return cell
    }
    
    

    
}

extension XiangViewController : UICollectionViewDelegateFlowLayout{
    
    
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: kScreenW, height: xiang.KXinagH+284)
    }
}

extension XiangViewController {
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
