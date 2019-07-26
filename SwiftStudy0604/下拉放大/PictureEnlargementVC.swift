//
//  PictureEnlargementVC.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/16.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit




let CELLID = "CELLID"



class PictureEnlargementVC: Base_ViewController {
    
    var bgView : UIImageView!   // 添加到tableview 的图片   这里把它放到tableView的下层
    var headerView : UIView!    // tableview的表头
    
    var originalFrame : CGRect!
    
    //自定义导航拦
    var customNavi : CustomNaviBar!
    
    let ratio = 0.751
    
    lazy var tableView:UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: Configs.Dimensions.screenHeight), style: .plain)
        table.backgroundColor = UIColor.clear
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: CELLID)
        table.tableFooterView = UIView()
        return table
    }()


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        navigationController?.navigationBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //添加表，和拉伸的ImageView
        configureWithTableView_HeadView_ImageView()
        
        //导航栏添加
        configureWithNavi()

    }



}
extension PictureEnlargementVC {
    
    func configureWithNavi() {
        //第二种：自定义导航栏 CustomNaviBar
        //导航栏
        self.customNavi = CustomNaviBar.init(frame: CGRect.init(x: 0, y: 0, width: Screen_Width, height: StateBar_Height+44.0))
        self.customNavi.backgroundColor = UIColor.clear
        self.view.addSubview(self.customNavi)
        customNavi.navButtonClosure = {type in
            if type == .leftButtonNavType {
                self.navigationController?.popViewController(animated: true)
            }else if type == .rightButtonNavType{
                print("点击了右边导航按钮")
            }
        }
        
    }
    
    func configureWithTableView_HeadView_ImageView() {
        view.addSubview(tableView)
        //图片
        self.bgView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: Screen_Width, height: Screen_Width*0.751))
        self.bgView.image = UIImage(named: "headerImage")
        self.view.addSubview(self.bgView)
        self.view.sendSubviewToBack(self.bgView)
        self.originalFrame = self.bgView.frame
        
        //头部
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Screen_Width, height: 160))
        headerView.backgroundColor = UIColor.clear
        tableView.tableHeaderView = headerView
        
        let advarBtn = UIButton(type: .custom)
        advarBtn.centerX = headerView.centerX
        advarBtn.centerY = headerView.centerY
        advarBtn.setTitle("头像", for: .normal)
        advarBtn.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        advarBtn.clipsToBounds = true
        advarBtn.layer.cornerRadius = 25
        advarBtn.titleLabel!.font = UIFont(name: Configs.Dimensions.wordRegular, size: 13.0)
        advarBtn.backgroundColor = UIColor.red
        headerView.addSubview(advarBtn)
        advarBtn.addTarget(self, action: #selector(changeImage), for: .touchUpInside)
    
    }
    
    @objc func changeImage() {
        let alertController = UIAlertController(title: "请选择", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: nil)
        let photoAction = UIAlertAction(title: "从相册选择", style: UIAlertAction.Style.default, handler: { action in
            CWLog("从相册选择")
            //调用相册功能，打开相册
            let picker = UIImagePickerController()
            picker.view.frame = CGRect(x: 0, y: 0, width: Configs.Dimensions.screenWidth, height: Configs.Dimensions.screenHeight)
            picker.sourceType = .photoLibrary
            picker.delegate = self
            //解决照片被导航栏遮挡的偏移问题
            picker.navigationBar.isTranslucent = false
            
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
        })
        
        let camereAction = UIAlertAction(title: "拍照", style: UIAlertAction.Style.destructive, handler: {action in
            CWLog("拍照")
            //判断是否能进行拍照，可以的话打开相机
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                picker.allowsEditing = true
                self.present(picker, animated: true, completion: nil)
            }else{
                print("模拟其中无法打开照相机,请在真机中使用");
            }
        })
        alertController.addAction(cancelAction)
        alertController.addAction(photoAction)
        alertController.addAction(camereAction)
        self.present(alertController, animated: true, completion: nil)

    }
    
}


// MARK: UITableViewDataSource  ，  UITableViewDelegate
extension PictureEnlargementVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELLID, for: indexPath)
        cell.textLabel?.text = "切换头像 + \(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("你点击了第\(indexPath.row)个cell")
        }
}

// MARK: UIImagePickerController 的代理方法
extension PictureEnlargementVC:UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //获取选择的原图
        let originImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        CWLog(originImage)

        //赋值，图片视图显示图片
        bgView?.image = originImage
        tableView.reloadData()
        //图片控制器退出
        picker.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: 根据偏移量配置导航栏透明度和图片拉伸
extension PictureEnlargementVC {
    
    func scrollViewDidScroll(_ scrollView:UIScrollView) {
        let off_Y = scrollView.contentOffset.y
        //导航栏颜色渐变
        if off_Y < 160 {
            //滑动到导航栏底部之前
            let cocloralph = off_Y/160
            self.customNavi.backgroundColor = UIColor.white.withAlphaComponent(cocloralph)
            self.customNavi.titleLabel.textColor = UIColor.white
            self.customNavi.leftBtn.setImage(UIImage.init(named: "button-返回"), for: .normal)
        }else{
            //滑动超过导航栏底部
            self.customNavi.backgroundColor = UIColor.white
            self.customNavi.titleLabel.textColor = UIColor.red
            self.customNavi.leftBtn.setImage(UIImage.init(named: "button-返回B"), for: .normal)
        }
        //图片往上移动效果、往下放大效果
        if off_Y > 0 {
            //移动,offset值是正的
            self.bgView.frame = {
                var bgFrame = originalFrame
                bgFrame?.origin.y = originalFrame.origin.y-off_Y
                return bgFrame!
            }()
        }else{
            //放大,往下offset是负的，负负得正
            self.bgView.frame = {
                var bgFrame = originalFrame
                bgFrame!.size.height = originalFrame.size.height-off_Y
                bgFrame!.size.width = ((bgFrame?.size.height)!)/CGFloat(ratio)
                bgFrame!.origin.x = (originalFrame.size.width-((bgFrame?.size.width)!))/2
                return bgFrame!
            }()
        }
        print("bgView \(self.bgView.frame)")
    }
    
}
