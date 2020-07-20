//
//  CollectionNormalCell.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/5/24.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {

    @IBOutlet weak var highlightIndicator: UIView!
    @IBOutlet weak var selectIndcator: UIImageView!
    @IBOutlet weak var Job: UILabel!
    @IBOutlet weak var Salary: UILabel!
    @IBOutlet weak var Workingyears: UILabel!
    @IBOutlet weak var Education: UILabel!
    @IBOutlet weak var Postlabel: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var Listed: UILabel!
    @IBOutlet weak var Staff: UILabel!
    @IBOutlet weak var AvatarImage: UIImageView!
    @IBOutlet weak var nicknameposition: UILabel!
    @IBOutlet weak var Jobcity: UILabel!
    override var isHighlighted: Bool {
      didSet {
        highlightIndicator.isHidden = !isHighlighted
      }
    }
    
    override var isSelected: Bool {
      didSet {
        highlightIndicator.isHidden = !isSelected
        selectIndcator.isHidden = !isSelected
      }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
//        tagber = UILabelPadding(withInsets:5, 5, 8,8)
        // Initialization code
    }

}
