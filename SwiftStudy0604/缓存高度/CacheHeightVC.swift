//
//  imagePicker_collectionViewController.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/6.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Foundation
import HandyJSON
import SwiftyJSON

class CacheHeightVC: UIViewController {

    lazy var tableView:UITableView = {
        let table = UITableView(frame: view.frame, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.register(cellType: Cache_Cell.self)
        table.tableFooterView = UIView()
//        table.estimatedRowHeight = 100
//        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    lazy var dataArray = [CalculatedHeight_Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(tableView)
        
        getData()

    }
    

    
}

extension CacheHeightVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:Cache_Cell = tableView.dequeueReusableCell(for: indexPath, cellType: Cache_Cell.self)
        
        cell.cellLayout = dataArray[indexPath.row]

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let celllayout = dataArray[indexPath.row]
        return celllayout.cellHeight!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


extension CacheHeightVC {

    //获取数据
    func getData() {
        dataArray.removeAll()
        // 从 Bundle 中加载配置的 json
        guard let path = Bundle.main.path(forResource: "dataCell_Height", ofType: "json"),
            let data = NSData(contentsOfFile: path) else {
                return
        }
        guard let json = try? JSON(data: data as Data) else { return }
        let array = json["feed"]
        for (_,sub) in array {
            let cacheM = CacheModel.init(jsonData: sub)
            let cellLayout = CalculatedHeight_Model(model: cacheM)
            dataArray.append(cellLayout)
        }
        CWLog(dataArray)
        tableView.reloadData()
    }
    
    
}
