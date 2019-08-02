//
//  Huoshan_ViewController.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/24.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Then
import SnapKit
import RxDataSources
import RxSwift
import RxCocoa
import NSObject_Rx
import Moya

class Huoshan_ViewController: Base_ViewController {
    ///初始化 ViewModel
    let viewModel = King_Welfare_View_Model()
    ///初始化 tableview
    let tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.register(cellType: Huoshan_Cell.self)
        $0.rowHeight = Huoshan_Cell.cellHeigh()
        $0.estimatedRowHeight = UITableView.automaticDimension
    }
    ///初始化 dataSources
    let dataSources = RxTableViewSectionedReloadDataSource<KingSection>(configureCell: { (de, tableView, indexPath, item) -> Huoshan_Cell in
        let cell:Huoshan_Cell = tableView.dequeueReusableCell(for: indexPath, cellType: Huoshan_Cell.self)
        cell.bigImageV.kf.setImage(with: URL(string: item.url))
        cell.desLabel.text = "描述：\(item.desc)"
        cell.fromLabel.text = "来源：\(item.source)"
        CWLog(item)
        return cell
    })
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "RxSwiftMVVM模式"
        addtableView()
        bindView()
        tableView.mj_header.beginRefreshing()
    }
}
// MARK: 设置数据
extension Huoshan_ViewController {
    fileprivate func bindView() {
        ///设置代理
        tableView.rx.setDelegate(self as UIScrollViewDelegate).disposed(by: rx.disposeBag)
        ///初始化 Input  Output
        let vm_Input = King_Welfare_View_Model.king_Intput(category: .welfare)
        let vm_Output = viewModel.transform(input: vm_Input)
        ///任何 'Observable' 序列都可以被转换为'Driver', 只要他满足一下三点：
        /// 1.不能出错   2.观察主线程  3.共享资源
        vm_Output.sections.asDriver().drive(tableView.rx.items(dataSource: dataSources)).disposed(by: disposeBag)
        
        /// 创建一个被观察者，监听点击事件   zip相当于把两个序列合并成一个序列    同时获取索引 和 model
        Observable.zip(tableView.rx.itemSelected,
                       tableView.rx.modelSelected(KingWelfare_Model.self))
            .bind { [unowned self] indexpath, item in
                self.showAlert(title: "点击了第 \(indexpath.row + 1) 行", message: "创建于 \(item.createdAtString ?? "2019年")")
            }.disposed(by: rx.disposeBag)

        ///配置刷新状态
        vm_Output.refreshStatus.asObservable().subscribe(onNext: { [unowned self] status in
            // MARK: 这里使用全局刷新状态，将刷新逻辑分离出去
            Configs.rsfresh_DataWith_TableView(tableView: self.tableView, status: status)
        }).disposed(by: disposeBag)
        ///下拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            vm_Output.requestCommond.onNext(true)
        })
        ///上拉加载
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            vm_Output.requestCommond.onNext(false)
        })
    }
}
// MARK: cell的点击
extension Huoshan_ViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: 添加界面控件
extension Huoshan_ViewController {
    func addtableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(view)
        }
    }
}

extension Huoshan_ViewController {
    func showAlert(title:String,message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
}
