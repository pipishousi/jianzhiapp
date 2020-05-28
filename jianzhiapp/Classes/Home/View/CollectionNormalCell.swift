//
//  CollectionNormalCell.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/5/24.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {

    @IBOutlet weak var tagber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tagber = UILabelPadding(withInsets:5, 5, 8,8)
        // Initialization code
    }

}
