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
    
    let viewModel = King_Welfare_View_Model()
    let tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.register(cellType: Huoshan_Cell.self)
        $0.rowHeight = Huoshan_Cell.cellHeigh()
        $0.estimatedRowHeight = UITableView.automaticDimension
    }
    
    let dataSources = RxTableViewSectionedReloadDataSource<KingSection>(configureCell: { (de, tableView, indexPath, item) -> Huoshan_Cell in
        let cell:Huoshan_Cell = tableView.dequeueReusableCell(for: indexPath, cellType: Huoshan_Cell.self)
        cell.bigImageV.kf.setImage(with: URL(string: item.url))
        cell.desLabel.text = "描述：\(item.desc)"
        cell.fromLabel.text = "来源：\(item.source)"
        return cell
    })
    
    var vm_Output : King_Welfare_View_Model.Output?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "RxSwiftMVVM模式"
        
        addtableView()
        bindView()
        tableView.mj_header.beginRefreshing()
    }
    


    
}

extension Huoshan_ViewController {
    func addtableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(view)
        }
    }
}

extension Huoshan_ViewController {
    fileprivate func bindView() {
        ///设置代理
        tableView.rx.setDelegate(self as UIScrollViewDelegate).disposed(by: rx.disposeBag)

        let vm_Input = King_Welfare_View_Model.king_Intput(category: .welfare)
        let vm_Output = viewModel.transform(input: vm_Input)
        
        vm_Output.sections.asDriver().drive(tableView.rx.items(dataSource: dataSources)).disposed(by: disposeBag)
        
        vm_Output.refreshStatus.asObservable().subscribe(onNext: { [weak self] status in
            switch status {
            case .beingHeaderRefresh:
                self?.tableView.mj_header.beginRefreshing()
            case .endHeaderRefresh:
                self?.tableView.mj_header.endRefreshing()
            case .beingFooterRefresh:
                self?.tableView.mj_footer.beginRefreshing()
            case .endFooterRefresh:
                self?.tableView.mj_footer.endRefreshing()
            case .noMoreData:
                self?.tableView.mj_footer.endRefreshingWithNoMoreData()
            default:
                break
            }
        }).disposed(by: disposeBag)
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            vm_Output.requestCommond.onNext(true)
        })
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            vm_Output.requestCommond.onNext(false)
        })

        
    }
}

extension Huoshan_ViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
