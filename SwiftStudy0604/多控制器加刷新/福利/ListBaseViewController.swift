//
//  ListBaseViewController.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/6/27.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import JXSegmentedView



class ListBaseViewController: UIViewController {
    
    var itemsArray = [WelfareModel]()
    var page :Int = 1

    lazy var tableView:UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: Configs.Dimensions.screenWidth, height: Configs.Dimensions.screenHeight-40-Configs.Dimensions.topHeight), style: .plain)
        table.register(cellType: ListBase_Cell.self)
        table.delegate = self
        table.dataSource = self
        table.estimatedRowHeight = 350
        table.rowHeight = UITableView.automaticDimension
        table.backgroundColor = UIColor.clear
        table.separatorStyle = .none
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        //下拉刷新
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] in
            self?.itemsArray.removeAll()
            self?.getTitleData(type: MyAPI.LXFNetworkCategory.welfare, size: 20, index: self!.page)
        })
        //上拉加载更多
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadmoreData))

        tableView.mj_header.beginRefreshing()

    
    }
    
    @objc func loadmoreData() {
        page += 1
        getTitleData(type: MyAPI.LXFNetworkCategory.welfare, size: 20, index: page)
    }

}

extension ListBaseViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}


extension ListBaseViewController :UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ListBase_Cell = tableView.dequeueReusableCell(for: indexPath, cellType: ListBase_Cell.self)
        
        cell.welfaModel = itemsArray[indexPath.row]
        
        return cell
    }
    
    
    
}


extension ListBaseViewController:NetWorkToolsProtocol {
    func getTitleData(type: MyAPI.LXFNetworkCategory, size:Int, index:Int) {
        
        
        NetWorkTools.KL_GetDataWithRequest(type: type, size: size, index: index) { [weak self](welfareArray) in
            self?.tableView.mj_header.endRefreshing()
            
            if welfareArray.count < 10 {
                self?.tableView.mj_footer.endRefreshingWithNoMoreData()
            }else{
                self?.tableView.mj_footer.endRefreshing()
            }
            
            for wealmodel in welfareArray {
                self?.itemsArray.append(wealmodel)
            }

            RequestLoadingPlugin().HUD.hide(animated: true, afterDelay: 0)
            self?.tableView.reloadData()
        }
    }
}




