//
//  AnchorGroup.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/6/7.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
//   /// 该组中对应的房间信息
//      var room_list : [[String : NSObject]]? {
//          didSet {
//              guard let room_list = room_list else { return }
//              for dict in room_list {
//                  anchors.append(AnchorModel(dict: dict))
//              }
//          }
//      }
      /// 组显示的图标
      var className : String = "JobOffers"
    /// 组显示的图标
    var objectId : String = "d3d63c8335"/// 组显示的图标
    var createdAt : String = "Sunday, June 7, 2020 at 10:16:12 PM China Standard Time"
    /// 组显示的图标
    var updatedAt : String = "Sunday, June 7, 2020 at 10:17:44 PM China Standard Time"
    var anchors : [NSObject]?
    init(dict : [NSObject]) {
        super.init()
        
//        setValuesForKeys(dict)
    }
      /// 定义主播的模型对象数组
//      lazy var anchors : [AnchorModel] = [AnchorModel]()
}
