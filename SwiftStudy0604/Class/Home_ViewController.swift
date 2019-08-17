//
//  Home_ViewController.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/24.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

let homeVCCell_ID  = "homeVCCell_ID"
class Home_ViewController: Base_ViewController {
    lazy var tableView:UITableView = {
        let table = UITableView(frame: view.frame, style: .plain)
        table.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        table.register(UITableViewCell.self, forCellReuseIdentifier: homeVCCell_ID)
        table.tableFooterView = UIView()
        return table
    }()
    private lazy var dataSource : [(String,Base_ViewController.Type)] = {
        [("分页控制，刷新加载更多" , Welfare_ViewController.self),
         ("二级嵌套" , CoinHomeViewController.self),
         ("动态九宫格" , DynamicNinePalaceLatticeVC.self),
         ("tableView缓存高度" , CacheHeightVC.self),
         ("轮播图_仿朋友圈" , BannerViewController.self),
         ("headimage放大" , PictureEnlargementVC.self),
         ("RxSwift响应式编程" , MyRegister_ViewController.self)
        ]
    }()
    //设置导航栏 这里用animated  保证返回的时候 过渡流畅
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        Driver.of(dataSource)
            .drive(tableView.rx.items(cellIdentifier: homeVCCell_ID)) {_ ,item ,cell in
                cell.textLabel?.text = item.0
        }.disposed(by: disposeBag)
        
//        tableView.rx.itemSelected
//            .bind(to: tableView.rx.deselectRow(animated: true))
//            .disposed(by: disposeBag)

        tableView.rx.modelSelected((String, Base_ViewController.Type).self)
            .map { $0.1 }
        .bind(to: rx.push)
            .disposed(by: disposeBag)
    }
}

// MARK: 给当前控制器扩展一个push动作的序列
extension Reactive where Base == Home_ViewController {
    var push : Binder<Base_ViewController.Type>{
        return Binder(base) { vc, type in
            vc.navigationController?.pushViewController(type.init(), animated: true)
        }
    }
}
// MARK: 给UITableView 扩展一个cell点击 的序列
extension Reactive where Base == UITableView {
    func deselectRow(animated: Bool = true) -> Binder<IndexPath> {
        return Binder(base) { tableView, indexPath in
            tableView.deselectRow(at: indexPath, animated: animated)
        }
    }
}












