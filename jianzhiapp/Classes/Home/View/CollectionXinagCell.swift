//
//  CollectionXinagCell.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/5/24.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit

protocol SelectkxiangViewHData{
    func SelectkxiangViewH(kxiangViewH: CGFloat)
}
class CollectionXinagCell: UICollectionViewCell {

      var delegate:SelectkxiangViewHData?
    

      

    override func awakeFromNib() {
        super.awakeFromNib()

    }
   
     
   
}

