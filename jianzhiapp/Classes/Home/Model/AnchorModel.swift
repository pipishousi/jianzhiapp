//
//  AnchorModel.swift
//  DYZB
//
//  Created by 1 on 16/9/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
     var Job = ""
       var Workingyears = ""
       var Education = ""
       var Postlabel = ""
       var company = ""
       var Listed = ""
       var Staff = ""
       var AvatarImage = ""
       var nickname = ""
       var position = ""
       var Jobcity = ""
       var recommend = true
       var Delivery = true
       init(dict : [String : Any]) {
           super.init()
           
           setValuesForKeys(dict)
       }
       override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
