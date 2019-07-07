//
//  ListBaseViewController.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/6/27.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import JXSegmentedView

let ListBaseViewCell_ID = "ListBaseViewCell_ID"


class ListBaseViewController: UIViewController {
    
    var itemsArray = [WelfareModel]()
    
    
    lazy var tableView:UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: Configs.Dimensions.screenWidth, height: Configs.Dimensions.screenHeight-40-Configs.Dimensions.topHeight), style: .plain)
//        table.backgroundColor = UIColor.lightGray
        table.register(ListBase_Cell.self, forCellReuseIdentifier: ListBaseViewCell_ID)
        table.delegate = self
        table.dataSource = self
        table.estimatedRowHeight = 50
        table.rowHeight = UITableView.automaticDimension
        table.backgroundColor = UIColor.clear
        table.separatorStyle = .none

        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTitleData(type: MyAPI.LXFNetworkCategory.welfare, size: 10, index: 1)
        view.backgroundColor = UIColor(red: CGFloat(arc4random()%255)/255, green: CGFloat(arc4random()%255)/255, blue: CGFloat(arc4random()%255)/255, alpha: 1)
        view.addSubview(tableView)

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
        let cell = tableView.dequeueReusableCell(withIdentifier: ListBaseViewCell_ID, for: indexPath) as! ListBase_Cell
        
        cell.welfaModel = itemsArray[indexPath.row]
        
        return cell
    }
    
    
    
}


extension ListBaseViewController:NetWorkToolsProtocol {
    func getTitleData(type: MyAPI.LXFNetworkCategory, size:Int, index:Int) {
        NetWorkTools.KL_GetDataWithRequest(type: type, size: size, index: index) { [weak self](welfareArray) in
            CWLog(welfareArray)
            for wealmodel in welfareArray {
                self?.itemsArray.append(wealmodel)
                CWLog(self!.itemsArray)
            }
            RequestLoadingPlugin().HUD.hide(animated: true, afterDelay: 0)
            self?.tableView.reloadData()
        }
    }
}




