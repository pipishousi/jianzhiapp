//
//  HomeViewController.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/5/21.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit
import CoreLocation
private let kTitleViewH : CGFloat = 40
private let kItemH : CGFloat = kScreenW*1/3
class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,CLLocationManagerDelegate {
    let xiang = Common()
    var citys = "杭州"
    var currLocation : CLLocation! //这个是保存定位信息的  别乱想哈
    let locationManager = CLLocationManager()
    
    //实现富文本
    var string = NSMutableAttributedString()
    let rightBtn = UIButton()
    var statusBarHeight: CGFloat = 0
    /// iPhoneX、iPhoneXR、iPhoneXs、iPhoneXs Max等
    /// 判断刘海屏，返回true表示是刘海屏
    ///
    
    
    //    // MARK:- 懒加载属性
    //    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
    //        let titleFrame = CGRect(x: 0, y: xiang.kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
    //        let titles = ["推荐", "最新"]
    //        let titleView = PageTitleView(frame: titleFrame, titles: titles)
    //        titleView.delegate = self
    //        return titleView
    //    }()
    //
    fileprivate lazy var RecommendViewVm : RecommendViewController = RecommendViewController()
   
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        
        // 1.确定内容的frame
        print(2)
        let contentH = kScreenH - xiang.kStatusBarH - (self?.navigationController!.navigationBar.frame.size.height)! - kTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: xiang.kStatusBarH + kNavigationBarH , width: kScreenW, height: contentH)
        
        // 2.确定所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        //        childVcs.append(GameViewController())
        //        childVcs.append(AmuseViewController())
        //        childVcs.append(FunnyViewController())
        //
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        //        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        if #available(iOS 13.0, *) {
            xiang.kStatusBarH = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            xiang.kStatusBarH = UIApplication.shared.statusBarFrame.height
        }
        
        self.view.backgroundColor = UIColor.white
        self.title = "首页"
        navigationController?.navigationBar.barTintColor = UIColor(r: 255, g: 223, b: 70)
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        locationManager.requestWhenInUseAuthorization() //请求授权获取当前位置
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters //设置位置精度 精度越高越好
        locationManager.requestLocation()//请求一次
        //        locationManager.startUpdatingLocation()//开始定位  在定位完成后 会调用协议方法  这个就不用多说了
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currLocation = locations.last
       let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currLocation) { (placemarksArray, error) in
//            print(placemarksArray!)
            if (error) == nil {
                if placemarksArray!.count > 0 {
                    let placemark = placemarksArray?[0]
                    let namestr = (placemark?.locality ?? "")
                    var str2 = ""
                    let address = "\(placemark?.subThoroughfare ?? ""), \(placemark?.thoroughfare ?? ""), \(placemark?.locality ?? ""), \(placemark?.subLocality ?? ""), \(placemark?.administrativeArea ?? ""), \(placemark?.postalCode ?? ""), \(placemark?.country ?? "")"
//                    print("\(address)")
                    if namestr.hasSuffix("区") == true {
                        str2 = namestr.replacingOccurrences(of: "区", with: "")
                    }else{
                        str2 = namestr.replacingOccurrences(of: "市", with: "")
                    }
                    self.RecommendViewVm.loadData(city:str2)
                    self.RecommendViewVm.string = str2
//                    self.citys = str2
//                    self.xiang.dangqiancity = str2
//                    print(self.xiang.dangqiancity)
                }
            }else{
                self.RecommendViewVm.loadData(city:"杭州")
            }

        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("获取位置失败")
    }
    
    //    func LonLatToCity() {
    //
    //            let geocoder: CLGeocoder = CLGeocoder()
    //
    //            geocoder.reverseGeocodeLocation(currLocation) { (placemark, error) -> Void in
    //                if(error == nil)//成功
    //                {
    //                    let array = placemark! as NSArray
    //
    //                    let mark = array.firstObject as! CLPlacemark
    //
    //                    //这个是城市
    //
    ////                    let city: String = (mark.addressDictionary! as NSDictionary).value(forKey: "City") as! String
    ////                    //这个是国家
    ////                    let country: NSString = (mark.addressDictionary! as NSDictionary).value(forKey: "Country") as! NSString
    ////
    ////                    //这个是国家的编码
    ////                    let CountryCode: NSString = (mark.addressDictionary! as NSDictionary).value(forKey: "CountryCode") as! NSString
    ////                    //这是街道位置
    ////                    let FormattedAddressLines: NSString = ((mark.addressDictionary! as NSDictionary).value(forKey: "FormattedAddressLines") as AnyObject).firstObject as! NSString
    ////                    //这是具体位置
    ////                    let Name: NSString = (mark.addressDictionary! as NSDictionary).value(forKey: "Name") as! NSString
    ////                    //这是省
    ////                    var State: String = (mark.addressDictionary! as NSDictionary).value(forKey: "State") as! String
    //                    //这是区
    //                    let SubLocality: NSString = (mark.addressDictionary! as NSDictionary).value(forKey: "SubLocality") as! NSString
    //                    xiang.dangqiancity = SubLocality as String
    //
    //                    print( SubLocality)
    //                }
    //
    //                else
    //
    //                {
    //                    print(error)
    //
    //
    //                }
    //
    //            }
    //
    //        }
}

//mack 加载样式
extension HomeViewController{
    
    
}
extension HomeViewController {
    //设置导航栏
    private func setupUI(){
        setupNavigationbBar()
        
        // 2.添加TitleView
        //        view.addSubview(pageTitleView)
        
        // 3.添加ContentView
        view.addSubview(pageContentView)
        
    }
    
    private  func setupNavigationbBar() {
        let size = CGSize(width: 10, height: 10)
        
        //设置左侧item
        //实现富文本
        string = NSMutableAttributedString(string:citys)
        
        
        //自定义导航左侧按钮
        let btn = UIButton.init(type:UIButton.ButtonType.roundedRect)
        btn.frame = CGRect(x: 0,y: 0,width: 70,height: 30);
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action:#selector(citydata), for: UIControl.Event.touchUpInside)
        let lbText:UILabel
        lbText = UILabel()
        lbText.frame = CGRect(x: 0,y: 0, width: btn.frame.size.width, height: btn.frame.size.height)
        lbText.attributedText = string
        lbText.textColor = UIColor(r: 48, g: 48, b: 48)
        lbText.font = UIFont.systemFont(ofSize: 16)
        btn.addSubview(lbText)
        btn.backgroundColor = UIColor.clear
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: btn)
        view.backgroundColor = UIColor.white
        
        
        
        
        //        rightBtn.sizeToFit()
        // right按钮
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: rightBtn)
        
        //设置右侧item
        let historyBtn = UIButton()
        historyBtn.setImage(UIImage(named: "Profile_m"), for: .normal)
        historyBtn.setImage(UIImage(named: "Profile_x"), for: .highlighted)
        historyBtn.frame = CGRect(origin: CGPoint.zero, size: size)
        //        historyBtn.sizeToFit()
        let qrcodeItem = UIBarButtonItem(customView: historyBtn)
        
        historyBtn.isUserInteractionEnabled = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.shoucangClick(_:)))
        historyBtn.addGestureRecognizer(tapGes)
        //        navigationItem.rightBarButtonItems = [qrcodeItem]
        
        
    }
}
//// MARK:- 遵守PageTitleViewDelegate协议
//extension HomeViewController : PageTitleViewDelegate {
//    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
////           pageContentView.setCurrentIndex(index)
//        if index == 1 {
//            let info = ["name":"date"] as [String : Any]
//            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "XMNotification"), object: "cityjob", userInfo: info)
//        }else{
//            let info = ["name":"tuijian"] as [String : Any]
//            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "XMNotification"), object: "cityjob", userInfo: info)
//        }
//
//
//    }
//}


// MARK:- 遵守PageContentViewDelegate协议
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        //        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
// MARK:- 遵守CityDelegate协议
extension HomeViewController : CityDelegate {
    func CityData(city: String) {
        self.citys = city
       self.RecommendViewVm.loadData(city:city)
        setupNavigationbBar()
        string = NSMutableAttributedString(string:city)
        
        //        print(city)
    }
    
    
}
extension HomeViewController{
    
    @objc fileprivate func shoucangClick(_ tapGes : UITapGestureRecognizer) {
        CBToast.showToastAction()
        
        //查找GameScore表
        
    }
    
    @objc fileprivate func citydata(sender:UIButton) {
        //            sender.isSelected = !sender.isSelected
        let login = CityViewController()
        login.delegate = self
        //全屏显示
        login.modalPresentationStyle = .fullScreen
        present(login, animated: true, completion: nil)
        //        navigationController?.pushViewController(login, animated: true)
        //        self.navigationController?.pushViewController(login, animated: true)
    }
}
