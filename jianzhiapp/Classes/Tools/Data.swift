//
//  Data.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/5/31.
//  Copyright © 2020 殷义军. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var username = ""
    @objc dynamic var userID = ""
     @objc dynamic var myadvantage  = ""
     @objc dynamic var wechatnumber  = ""
    @objc dynamic var touxiangImage  = ""
     @objc dynamic var name  = ""
    @objc dynamic var gender  = true
   
    @objc dynamic var id = NSUUID().uuidString
    override static func primaryKey() ->String?{
        return "id"
    }
}
class JobOffers: Object {
    @objc dynamic var id = ""
    @objc dynamic var Job = ""
    @objc dynamic var position = ""
    @objc dynamic var Workingyears = ""
    @objc dynamic var Education = ""
    @objc dynamic var Postlabel = ""
    @objc dynamic var company = ""
    @objc dynamic var Listed = ""
    @objc dynamic var Staff = ""
    @objc dynamic var AvatarImage = ""
    @objc dynamic var nickname = ""
    @objc dynamic var Salary = ""
    @objc dynamic var Jobcity = ""
     @objc dynamic var jobRequirements = ""
    @objc dynamic var shoucang = true
    @objc dynamic var recommend = true
    @objc dynamic var Delivery = true
     @objc dynamic var updatedAt = Date()
    override static func primaryKey() -> String? {
        return "id"
    }

}
class  Gongzuoxinxi: Object{
    @objc var id = ""
    @objc var biaoti = ""
    @objc var gongzi = ""
    @objc var gongzuochengshi = ""
    @objc var gongzuoshijian = ""
    @objc var gongzuoxiangqing = ""
    @objc var gongzuozhonglei = ""
    @objc var jibengongzi = ""
    @objc var jiesuanfangshi = ""
    @objc var shangabnshiduan = ""
    @objc var shangbandidian = ""
    @objc var zhaopinrenshu = ""
    @objc var updatedAt = Date()
    override static func primaryKey() -> String? {
        return "id"
    }
}

