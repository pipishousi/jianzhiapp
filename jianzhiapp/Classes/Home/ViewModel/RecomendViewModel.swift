//
//  RecomendViewModel.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/6/7.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit
import RealmSwift
class RecomendViewModel{
    private lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    let renmeVc = RecommendViewController()
    let xiang = Common()
    var city = "杭州"
    
    var cesafas:[String:String] = [:]
    let JobDatas = Common()
    var  userzhanghao :Results<User>?
     let Gongzuoxinxis = Gongzuoxinxi()
    // 获取默认的 Realm 数据库
    let realm = try! Realm()
    let JobOffer = JobOffers()
    let myDog = User()
   
    
    
    
}
extension RecomendViewModel{

//        func requestData(finishCallback : () -> ()){
//    
//    
//            let query:BmobQuery = BmobQuery(className: "JobOffers")
//            query.findObjectsInBackground { (array, error) in
//    
//                for i in 0..<array!.count{
//                    let JobOfferer = array![i] as! BmobObject
//                    let JobOffer = JobOffers()
//                    JobOffer.Job = (JobOfferer.object(forKey: "Job") as? String)!
//                    JobOffer.position = (JobOfferer.object(forKey: "position") as? String)!
//                    JobOffer.Workingyears = (JobOfferer.object(forKey: "Workingyears") as? String)!
//                    JobOffer.Education = (JobOfferer.object(forKey: "Education") as? String)!
//                    JobOffer.Postlabel = (JobOfferer.object(forKey: "Postlabel") as? String)!
//                    JobOffer.company = (JobOfferer.object(forKey: "company") as? String)!
//                    JobOffer.Listed = (JobOfferer.object(forKey: "Listed") as? String)!
//                    JobOffer.Staff = (JobOfferer.object(forKey: "Staff") as? String)!
//                    JobOffer.AvatarImage = (JobOfferer.object(forKey: "AvatarImage") as? String)!
//                    JobOffer.nickname = (JobOfferer.object(forKey: "nickname") as? String)!
//                    JobOffer.Salary = (JobOfferer.object(forKey: "Salary") as? String)!
//                    JobOffer.Jobcity = (JobOfferer.object(forKey: "Jobcity") as? String)!
//                    JobOffer.jobRequirements = (JobOfferer.object(forKey: "jobRequirements") as? String)!
//                    JobOffer.shoucang = (JobOfferer.object(forKey: "shoucang") as? Bool)!
//                    JobOffer.recommend = (JobOfferer.object(forKey: "recommend") as? Bool)!
//                    JobOffer.Delivery = (JobOfferer.object(forKey: "Delivery") as? Bool)!
//                    JobOffer.updatedAt = (JobOfferer.updatedAt)!
//                    JobOffer.id = (JobOfferer.object(forKey: "objectId") as? String)!
////                    self.requestimage (id : JobOffer.id)
//                    self.JobDatas.JobOffersdata.append(JobOffer)
//    
//                    self.saveuserData(JobOfferer: JobOffer)
//    
//                }
//            }
//    
//            print("我是中间层")
//            finishCallback()
//        }
//    func requestimage (id : String ) {
//        let query:BmobQuery = BmobQuery(className: "Movie")
//        //获取缓存数据
//        userzhanghao = realm.objects(User.self)
//        if userzhanghao!.count > 0 {
//            query.findObjectsInBackground { (array, error) in
//                query.whereKey("userid", equalTo: self.xiang.dangqiancity)
//                if array != nil{
//                    for y in 0..<array!.count{
//                        let obj = array![y] as! BmobObject
//                        let  file = obj.object(forKey: "file") as? BmobFile
//                        self.myDog.touxiangImage = file?.url! as! String
//                        try! self.realm.write {
//                            self.realm.create(User.self, value: ["id": self.userzhanghao![0].userID , "touxiangImage": self.myDog.touxiangImage], update: .modified)
//                            // the book's `title` property will remain unchanged.
//                        }
//
//
//                    }
//                }
//
//            }
//        }
//
//
//
//    }
//    func saveuserData(JobOfferer: JobOffers ){
//        try! realm.write {
//            realm.add(JobOfferer, update: .modified)
//        }
//
//    }
//
}

extension RecomendViewModel{
    //    //定义一个闭包表达式为函数最终参数的函数
//        func trailingClosures(parameter:String,block:(_:String)->Void) -> Void {
//            let group = DispatchGroup()
//            group.enter()
//            let query:BmobQuery = BmobQuery(className: "gognzuoxinxi")
//            query.whereKey("gongzuochengshi", equalTo: city)
//
//            query.findObjectsInBackground { (arrays, error) in
//                //            print(array)
//                for i in 0..<arrays!.count{
////                    print(parameter)
//                    let JobOfferer = arrays![i] as! BmobObject
//                    self.Gongzuoxinxi.biaoti = (JobOfferer.object(forKey: "biaoti") as? String)!
//                    self.Gongzuoxinxi.gongzi = (JobOfferer.object(forKey: "gongzi") as? String)!
//                    self.Gongzuoxinxi.gongzuochengshi = (JobOfferer.object(forKey: "gongzuochengshi") as? String)!
//                    self.Gongzuoxinxi.gongzuoshijian = (JobOfferer.object(forKey: "gongzuoshijian") as? String)!
//                    self.Gongzuoxinxi.gongzuoxiangqing = (JobOfferer.object(forKey: "gongzuoxiangqing") as? String)!
//                    self.Gongzuoxinxi.gongzuozhonglei = (JobOfferer.object(forKey: "gongzuozhonglei") as? String)!
//                    self.Gongzuoxinxi.jibengongzi = (JobOfferer.object(forKey: "jibengongzi") as? String)!
//                    self.Gongzuoxinxi.jiesuanfangshi = (JobOfferer.object(forKey: "jiesuanfangshi") as? String)!
//                    self.Gongzuoxinxi.shangabnshiduan = (JobOfferer.object(forKey: "shangabnshiduan") as? String)!
//                    self.Gongzuoxinxi.shangbandidian = (JobOfferer.object(forKey: "shangbandidian") as? String)!
//                    self.Gongzuoxinxi.zhaopinrenshu = (JobOfferer.object(forKey: "zhaopinrenshu") as? String)!
//                    self.Gongzuoxinxi.updatedAt = (JobOfferer.updatedAt)!
//                    self.Gongzuoxinxi.id = (JobOfferer.object(forKey: "objectId") as? String)!
//                    //                self.requestimage (id : self.JobOffer.id)
//                    //                self.JobDatas.JobOffersdata.append(JobOffer)
//                    self.gongzuoxinxis.append(self.Gongzuoxinxi)
//
//
//                }
//                 group.leave()
//                print(self.gongzuoxinxis[0].gongzuochengshi)
//                //                    print(self.xiang.dangqiancity)
//            }
//            group.notify(queue: .main) {
////                print(parameter)
////                block(parameter+"dfjdskfjklsjflkdsjflksd")
//            }
//
//        }
    
        func requestgognzuoxinxiData(_ finishCallback : () -> ()) {
//            print( city)
            let group = DispatchGroup()
             group.enter()
            let query:BmobQuery = BmobQuery(className: "gognzuoxinxi")
            query.whereKey("gongzuochengshi", equalTo: city)

            query.findObjectsInBackground { (arrays, error) in
//                            print(arrays)
                for i in 0..<arrays!.count{
                    let JobOfferer = arrays![i] as! BmobObject
                     let Gongzuoxinxis = Gongzuoxinxi()
                    Gongzuoxinxis.biaoti = (JobOfferer.object(forKey: "biaoti") as? String)!
                    Gongzuoxinxis.gongzi = (JobOfferer.object(forKey: "gongzi") as? String)!
                    Gongzuoxinxis.gongzuochengshi = (JobOfferer.object(forKey: "gongzuochengshi") as? String)!
                    Gongzuoxinxis.gongzuoshijian = (JobOfferer.object(forKey: "gongzuoshijian") as? String)!
                    Gongzuoxinxis.gongzuoxiangqing = (JobOfferer.object(forKey: "gongzuoxiangqing") as? String)!
                    Gongzuoxinxis.gongzuozhonglei = (JobOfferer.object(forKey: "gongzuozhonglei") as? String)!
                    Gongzuoxinxis.jibengongzi = (JobOfferer.object(forKey: "jibengongzi") as? String)!
                    Gongzuoxinxis.jiesuanfangshi = (JobOfferer.object(forKey: "jiesuanfangshi") as? String)!
                    Gongzuoxinxis.shangabnshiduan = (JobOfferer.object(forKey: "shangabnshiduan") as? String)!
                    Gongzuoxinxis.shangbandidian = (JobOfferer.object(forKey: "shangbandidian") as? String)!
                    Gongzuoxinxis.zhaopinrenshu = (JobOfferer.object(forKey: "zhaopinrenshu") as? String)!
                    Gongzuoxinxis.updatedAt = (JobOfferer.updatedAt)!
                    Gongzuoxinxis.id = (JobOfferer.object(forKey: "objectId") as? String)!
                    self.JobDatas.GongZuoXinXis.append(Gongzuoxinxis)
                    self.saveuserData(gongzuoxinxir: Gongzuoxinxis)
                }
                group.leave()
            }
            finishCallback()
            group.notify(queue: .main) {
//                finishCallback()
            }
        }
    func saveuserData(gongzuoxinxir: Gongzuoxinxi){
           try! realm.write {
               realm.add(gongzuoxinxir, update: .modified)
           }



       }
//    func requestgognzuoxinxiData(parameter:String,block:(_:String)->Void) -> Void {
////        var asset:String = "0"
//        let group = DispatchGroup()
//        group.enter()
//        let query:BmobQuery = BmobQuery(className: "gognzuoxinxi")
//        query.whereKey("gongzuochengshi", equalTo: self.xiang.dangqiancity)
//
//        query.findObjectsInBackground { (arrays, error) in
//            //            print(array)
//            for i in 0..<arrays!.count{
//                let JobOfferer = arrays![i] as! BmobObject
//                self.Gongzuoxinxi.biaoti = (JobOfferer.object(forKey: "biaoti") as? String)!
//                self.Gongzuoxinxi.gongzi = (JobOfferer.object(forKey: "gongzi") as? String)!
//                self.Gongzuoxinxi.gongzuochengshi = (JobOfferer.object(forKey: "gongzuochengshi") as? String)!
//                self.Gongzuoxinxi.gongzuoshijian = (JobOfferer.object(forKey: "gongzuoshijian") as? String)!
//                self.Gongzuoxinxi.gongzuoxiangqing = (JobOfferer.object(forKey: "gongzuoxiangqing") as? String)!
//                self.Gongzuoxinxi.gongzuozhonglei = (JobOfferer.object(forKey: "gongzuozhonglei") as? String)!
//                self.Gongzuoxinxi.jibengongzi = (JobOfferer.object(forKey: "jibengongzi") as? String)!
//                self.Gongzuoxinxi.jiesuanfangshi = (JobOfferer.object(forKey: "jiesuanfangshi") as? String)!
//                self.Gongzuoxinxi.shangabnshiduan = (JobOfferer.object(forKey: "shangabnshiduan") as? String)!
//                self.Gongzuoxinxi.shangbandidian = (JobOfferer.object(forKey: "shangbandidian") as? String)!
//                self.Gongzuoxinxi.zhaopinrenshu = (JobOfferer.object(forKey: "zhaopinrenshu") as? String)!
//                self.Gongzuoxinxi.updatedAt = (JobOfferer.updatedAt)!
//                self.Gongzuoxinxi.id = (JobOfferer.object(forKey: "objectId") as? String)!
//                self.gongzuoxinxis.append(self.Gongzuoxinxi)
//            }
//            //            lihdasj()
//            print(self.gongzuoxinxis[0].gongzuochengshi)
//            group.leave()
//            group.notify(queue: .main) {  // group中的所有任务完成后再主线程中调用回调函数，将结果传出去
//                block("\(parameter)")  //在回调里将累加结果传出去
//            }
//        }
//    }
}
