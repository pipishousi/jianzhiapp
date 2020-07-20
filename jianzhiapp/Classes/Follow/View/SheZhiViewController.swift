//
//  SheZhiViewController.swift
//  jianzhiapp
//
//  Created by 殷义军 on 2020/6/4.
//  Copyright © 2020 殷义军. All rights reserved.
//

import UIKit
import RealmSwift
import AlamofireImage
protocol TouxiangImageDelegate {
    func TouxiangImageData(touxiangImage: String)
    func nameData(name: String)
}

class SheZhiViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var delegate: TouxiangImageDelegate?
    
    let tap = UITapGestureRecognizer()
    var  userzhanghao :Results<User>?
    // 获取默认的 Realm 数据库
    let realm = try! Realm()
    // MARK:- 懒加载属性
    private lazy var recommendMV : MeViewController = MeViewController()
    var imagePicker: UIImagePickerController = UIImagePickerController()
    @IBOutlet weak var headPortraitImg: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var sexlabel: UILabel!
    @IBOutlet weak var wechatlabel: UILabel!
    @IBOutlet weak var advantagelabel: UILabel!
    @IBAction func headPortraitTapClick(sender: UITapGestureRecognizer) {
        
        //调相册或相机
        let alertController = UIAlertController(title: "更换头像", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        let takePhotoAction = UIAlertAction(title: "相机", style: UIAlertAction.Style.default) { ( alertAction : UIAlertAction) in
            self.takePhoto()
        }
        let localPhotoAction = UIAlertAction(title: "相册", style: UIAlertAction.Style.default) { ( alertAction : UIAlertAction) in
            self.localPhoto()
        }
        let otherAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel) { ( alertAction : UIAlertAction) in
            print("取消")
        }
        
        alertController.addAction(takePhotoAction)
        alertController.addAction(localPhotoAction)
        alertController.addAction(otherAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func usernamebtn(_ sender: Any) {
        let usernameVc = UsernameViewController()
        usernameVc.delegate = self
        usernameVc.UsernametextField.text = username.text
        navigationController?.pushViewController(usernameVc, animated: true)
        
    }
    @IBAction func sexbtn(_ sender: Any) {
        addAlertUI()
        
        //        let sexVc = SexViewController()
        //        navigationController?.pushViewController(sexVc, animated: true)
    }
    @IBAction func wechatnumberbtn(_ sender: Any) {
        
        let wechatnumberVc = WechatnumberViewController()
        wechatnumberVc.delegate = self
        wechatnumberVc.textField.text = wechatlabel.text
        navigationController?.pushViewController(wechatnumberVc, animated: true)
    }
    @IBAction func Advantagebtn(_ sender: Any) {
        let AdvantageVc = AdvantageViewController()
        AdvantageVc.delegate = self
        AdvantageVc.UsernametextField.text = advantagelabel.text
        navigationController?.pushViewController(AdvantageVc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置头像图片
        setupImage()
        /// 2. 设置 picker 的 delegate 和 相关设置
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        headPortraitImg.isUserInteractionEnabled = true
        headPortraitImg.addGestureRecognizer(tap) //将手势添加到UIImageView上
        
        tap.addTarget(self, action: #selector(headPortraitTapClick(sender:)))
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
        
    }
    //设置头像图片
    func setupImage(){
        print("我是获取头像")
        //布局个人中心菜单
        let user = BmobUser.getCurrent()
        let query:BmobQuery = BmobQuery(className: "_User")
        query.getObjectInBackground(withId: user!.objectId!) { (obj, error) in
            if error != nil {
                //进行错误处理
            }else{
                let user = obj as! BmobUser
                if user.object(forKey: "name") as? String != nil{
                    self.username.text =  (user.object(forKey: "name") as? String)!
                    
                }else{
                    self.username.text =  " "
                }
                if user.object(forKey: "wechatnumber") as? String != nil{
                    self.wechatlabel.text = (user.object(forKey: "wechatnumber") as? String)!
                    
                }else{
                    self.wechatlabel.text =  " "
                }
                if user.object(forKey: "myadvantage") as? String != nil{
                    self.advantagelabel.text = (user.object(forKey: "myadvantage") as? String)!
                    
                }else{
                    self.advantagelabel.text  =  " "
                }
                print(user.object(forKey: "gender") as? Bool)
                if user.object(forKey: "gender") as? Bool != nil {
                     if (user.object(forKey: "gender") as? Bool)! == true  {
                                       self.sexlabel.text = "男"
                                   }else{
                                       self.sexlabel.text = "女"
                                   }
                }else{
                    self.sexlabel.text = "男"

                }
               
                if user.object(forKey: "touxiangImage") as? String != nil{
                    let placeholderImage = UIImage(named: "touxiang4")!
                    let url = URL(string: (user.object(forKey: "touxiangImage") as? String)!)
                    self.headPortraitImg.af_setImage(withURL: url!, placeholderImage: placeholderImage)
                    
                }else{
                    self.headPortraitImg.image  = UIImage(named: "touxiang4")
                }
                
            }
            
            
        }
        
    }
    //    相机
    func takePhoto(){
        let sourceType = UIImagePickerController.SourceType.camera
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = sourceType
            self.present(picker, animated: true, completion: nil)
            
        }else{
            print("模拟器中无法打开照相机,请在真机中使用")
        }
        
        
    }
    //    相册
    func localPhoto(){
        present(imagePicker, animated: true) {
            print("UIImagePickerController: presented")
        }
        
    }
    //选择图片成功后代理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        /// 5. 用户选中一张图片时触发这个方法，返回关于选中图片的 info
        /// 6. 获取这张图片中的 originImage 属性，就是图片本身
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("error: did not picked a photo")
        }
        /// 7. 根据需要做其它相关操作，这里选中图片以后关闭 picker controller 即可
        picker.dismiss(animated: true) { [unowned self] in
            //获取选择的原图
            let pickedImage = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as! UIImage
            
            //将选择的图片保存到Document目录下
            let fileManager = FileManager.default
            let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                               .userDomainMask, true)[0] as String
            
            let filePath = "\(rootPath)/pickedimage.jpg"
            let imageData = pickedImage.jpegData(compressionQuality: 1.0)
            fileManager.createFile(atPath: filePath, contents: imageData, attributes: nil)
            //            print(filePath)
            //上传图片
            if FileManager.default.fileExists(atPath: filePath ){
                let obj = BmobObject(className: "Movie")
                let  file = BmobFile(filePath: filePath);
                file!.saveInBackground { [weak file] (isSuccessful, error) in
                    if isSuccessful {
                        //如果文件保存成功，则把文件添加到file列
                        let weakFile = file
                        obj!.setObject(weakFile, forKey: "file")
                        obj!.saveInBackground(resultBlock: { (success, err) in
                            if err != nil {
                                print("save \(String(describing: error))")
                            }else{
                                print("\(success)")
                            }
                        })
                        print(weakFile!.url!)
                        self.updateuser(imageurl: weakFile!.url!)
                        
                        //进行操作
                        self.delegate!.TouxiangImageData(touxiangImage: weakFile!.url!)
                        
                    }else{
                        print("upload \(error)")
                    }
                }
            }
            
            self.headPortraitImg.image = selectedImage
        }
        
        
        
    }
    func updateuser(imageurl: String){
        let user = BmobUser.getCurrent()
        user!.setObject(imageurl, forKey: "touxiangImage")
        user!.setObject("我是小白", forKey: "name")
        user!.updateInBackground { (isSuccessful, error) in
            print(isSuccessful)
        }
    }
    func addAlertUI() {
        let alert = UIAlertController(title: "选择", message: "", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "男", style: .default, handler: {
            ACTION in
            self.sexuptext(sex: "男")
            
        })
        
        let ok = UIAlertAction(title: "女", style: .default, handler: {
            ACTION in
            self.sexuptext(sex: "女")
            
        })
        let del = UIAlertAction(title: "取消", style: .cancel, handler: {
            ACTION in
            
        })
        
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addAction(del)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func sexuptext(sex: String){
        let user = BmobUser.getCurrent()
        if sex == "男" {
            user!.setObject(true, forKey: "gender")
            user!.updateInBackground { (isSuccessful, error) in
            }
        }else{
            user!.setObject(false, forKey: "gender")
            user!.updateInBackground { (isSuccessful, error) in
            }
        }
        
        sexlabel.text = sex
    }
    
}
//遵守代理协议
extension SheZhiViewController:wechatnumberDeleget,UsernameDeleget,myadvantageDeleget{
    func myadvantageData(myadvantage: String) {
        advantagelabel.text = myadvantage
        
    }
    
    func UsernameData(Username: String) {
        username.text = Username
        delegate!.nameData(name: Username)
    }
    
    func wechatnumberData(weahatnumber: String) {
        wechatlabel.text = weahatnumber
    }
    
    
}
extension SheZhiViewController{
    
    
}
