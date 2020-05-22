//
//  ViewController.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/5/19.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        queryUsers()
        // Do any additional setup after loading the view.
    }
    func queryUsers()  {
        //查找GameScore表
        let query:BmobQuery = BmobQuery(className: "GameScore")
        query.findObjectsInBackground { (array, error) in
            for i in 0..<array!.count{
                let obj = array![i] as! BmobObject
                let playerName = obj.object(forKey: "playerName") as? String
                //打印玩家名
                print("playerName \(playerName)")
                //打印objectId,createdAt,updatedAt
                print("objectid   \(obj.objectId)")
                print("createdAt  \(obj.createdAt)")
                print("updatedAt  \(obj.updatedAt)")
            }
        }
    }

}

