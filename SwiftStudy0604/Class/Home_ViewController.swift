//
//  Home_ViewController.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/24.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

//let cellId = "cellID"
class Home_ViewController: Base_ViewController {
//    let disposeBag = DisposeBag()
    
    var nameString : String?
    let device_id = "6096495334"
    
    lazy var tableView:UITableView = {
        let table = UITableView(frame: view.frame, style: .plain)
        table.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        table.tableFooterView = UIView()
        return table
    }()
    
    lazy var stringArr = {() -> [String] in
        var array = [String]()
        array.append("分页控制，刷新加载更多")
        array.append("二级嵌套")
        array.append("动态九宫格")
        array.append("tableView缓存高度")
        array.append("轮播图_仿朋友圈")
        array.append("headimage放大")
//        array.append("Realm使用")
        return array
    }()
    
    //设置导航栏 这里用animated  保证返回的时候 过渡流畅
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        
        view.addSubview(tableView)
        
        
    }
    
}



extension Home_ViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stringArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = "点击跳转到\(stringArr[indexPath.row])"
        if indexPath.row == 4 {
            cell.textLabel?.textColor = UIColor.red
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            let welfareVC = Welfare_ViewController()
            self.navigationController?.pushViewController(welfareVC, animated: true)
            
        }else if indexPath.row == 1 {
            let coinVC = CoinHomeViewController()
            self.navigationController?.pushViewController(coinVC, animated: true)
            
        }else if indexPath.row == 2 {
            let dongtaiVC = DynamicNinePalaceLatticeVC()
            self.navigationController?.pushViewController(dongtaiVC, animated: true)
        }else if indexPath.row == 3 {
            let cache_VC = CacheHeightVC()
            cache_VC.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            cache_VC.title = stringArr[indexPath.row]
            self.navigationController?.pushViewController(cache_VC, animated: true)
        }else if indexPath.row == 4 {
            
            let banner_VC = BannerViewController()
            banner_VC.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            banner_VC.title = stringArr[indexPath.row]
            self.navigationController?.pushViewController(banner_VC, animated: true)
            
        }else if indexPath.row == 5 {
            let pic_VC = PictureEnlargementVC()
            pic_VC.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            pic_VC.title = stringArr[indexPath.row]
            self.navigationController?.pushViewController(pic_VC, animated: true)
            
        }
//        else if indexPath.row == 6 {
//            let Realm_VC = RealmViewController()
//            Realm_VC.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//            //            Realm_VC.title = stringArr[indexPath.row]
//            self.navigationController?.pushViewController(Realm_VC, animated: true)
//
//        }
    }
    
    
}













