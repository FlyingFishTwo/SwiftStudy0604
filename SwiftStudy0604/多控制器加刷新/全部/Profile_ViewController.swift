//
//  Profile_ViewController.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/9.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import JXSegmentedView

class Profile_ViewController: UIViewController {
    
    var dataArray = [WelfareModel]()
    var page = 1
    
    lazy var tableView:UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: Configs.Dimensions.screenWidth, height: Configs.Dimensions.screenHeight-40-Configs.Dimensions.topHeight), style: .plain)
        table.register(cellType: All_Cell.self)
        table.delegate = self
        table.dataSource = self
        table.estimatedRowHeight = 50
        table.rowHeight = UITableView.automaticDimension
        table.tableFooterView = UIView()
        table.separatorStyle = .none
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] in
            self?.dataArray.removeAll()
            self?.getTitleDataALL(type: MyAPI.LXFNetworkCategory.all, size: 20, index: 1)
        })
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(lodaMoreData_All))
        tableView.mj_header.beginRefreshing()
        
    }
    
    @objc func lodaMoreData_All() {
        page += 1
        getTitleDataALL(type: MyAPI.LXFNetworkCategory.all, size: 20, index: page)
    }


}

extension Profile_ViewController :UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:All_Cell = tableView.dequeueReusableCell(for: indexPath, cellType: All_Cell.self)

        cell.all_Model = dataArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}




extension Profile_ViewController:NetWorkToolsProtocol {
    func getTitleDataALL(type: MyAPI.LXFNetworkCategory, size:Int, index:Int) {
        
        NetWorkTools.KL_GetDataWithRequest(type: type, size: size, index: index) { [weak self](welfareArray) in
            self?.tableView.mj_header.endRefreshing()
            if welfareArray.count < 10 {
                self?.tableView.mj_footer.endRefreshingWithNoMoreData()
            }else{
                self?.tableView.mj_footer.endRefreshing()
            }
            for model in welfareArray {
                self?.dataArray.append(model)
            }
            CWLog(self!.dataArray)
            RequestLoadingPlugin().HUD.hide(animated: true, afterDelay: 0)
            self?.tableView.reloadData()
        }
    }
}




extension Profile_ViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
