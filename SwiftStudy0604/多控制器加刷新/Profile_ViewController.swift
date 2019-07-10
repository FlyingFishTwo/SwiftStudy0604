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
    
    var itemsArray = [WelfareModel]()
    
    lazy var tableView:UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: Configs.Dimensions.screenWidth, height: Configs.Dimensions.screenHeight-40-Configs.Dimensions.topHeight), style: .plain)
        table.register(cellType: ListBase_Cell.self)
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

//        getTitleData(type: MyAPI.LXFNetworkCategory.all, size: 20, index: 1)
        view.addSubview(tableView)
        

    }
    


}

extension Profile_ViewController :UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ListBase_Cell = tableView.dequeueReusableCell(for: indexPath, cellType: ListBase_Cell.self)
//        cell.welfaModel = itemsArray[indexPath.row]
        
        cell.backgroundColor = UIColor.red
        
        return cell
    }
    
    
}




extension Profile_ViewController:NetWorkToolsProtocol {
    func getTitleData(type: MyAPI.LXFNetworkCategory, size:Int, index:Int) {
        
        itemsArray.removeAll()
        
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




extension Profile_ViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
