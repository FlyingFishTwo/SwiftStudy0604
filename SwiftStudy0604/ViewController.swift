//
//  ViewController.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/6/4.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Alamofire
import RxCocoa
import RxSwift


let cellId = "cellID"
class ViewController: UIViewController {
    let disposeBag = DisposeBag()

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
        array.append("分页福利")
        array.append("我的关注")
        array.append("动态九宫格")
        array.append("tableView缓存高度")
        array.append("轮播图_朋友圈缓存高度")
        return array
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        
        // tableView 从导航栏以下开始
        self.edgesForExtendedLayout = UIRectEdge(rawValue: UIRectEdge.left.rawValue | UIRectEdge.bottom.rawValue | UIRectEdge.right.rawValue);

        
        view.addSubview(tableView)
        
        
    }
    
}



extension ViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stringArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = "点击跳转到\(stringArr[indexPath.row])"
        
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
            
        }
    }
    
    
}















/// 这里要遵守协议
extension ViewController :Back_ViewDelegate{

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let secondVC = SecondViewController()

//        //闭包  调用传值 字符串
//        secondVC.callBackString = { nameString in
//            print(nameString)
//        }
//        //闭包  调用传值 CGFloat
//        secondVC.returnPrice = { floatprice in
//            print(floatprice)
//        }
//        //闭包  调用传值 枚举值
//        secondVC.typePrice = { type in
//            print(type)
//        }
        
        // 指定代理关系
        secondVC.delegate = self
        
        
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    ///实现代理方法
    func returnValue(text :String) {
        print(text)
    }
    
}




