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
    
    //顶部的图片和View
    lazy var headerImageViewTop:UIImageView = {
        let header = UIImageView(frame: CGRect(x:0,y:0,width:Configs.Dimensions.screenWidth,height:160))
        header.backgroundColor = UIColor.red
        header.image = UIImage(named: "beautyGirl")
        header.contentMode = UIView.ContentMode.scaleAspectFill
        header.clipsToBounds = true
        return header
    }()
    // 懒加载headerView
    lazy var headerBackView:UIView = {
        let headerView = UIView.init(frame: CGRect(x:0,y:0,width:Configs.Dimensions.screenWidth,height:160))
        headerView.backgroundColor = UIColor.lightGray
        return headerView
    }()


    
    lazy var tableView:UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: Configs.Dimensions.screenWidth, height: Configs.Dimensions.screenHeight), style: .plain)
        table.delegate = self
        table.dataSource = self
        table.register(cellType: Cache_Cell.self)
        table.tableFooterView = UIView()
//        table.estimatedRowHeight = 100
//        table.rowHeight = UITableView.automaticDimension
        
        table.tableHeaderView = self.headerBackView
        self.headerBackView.addSubview(self.headerImageViewTop)
        return table
    }()
    
    lazy var dataArray = [CalculatedHeight_Model]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableView 从导航栏以下开始
        self.edgesForExtendedLayout = UIRectEdge(rawValue: UIRectEdge.left.rawValue | UIRectEdge.bottom.rawValue | UIRectEdge.right.rawValue);

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

extension CacheHeightVC {
    //MARK:- 滚动tableView后   在代理中设置滚动时的坐标变化
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let imageWeight:CGFloat = headerImageViewTop.frame.size.width
        //上下偏移量
        let imageOffsetY:CGFloat = scrollView.contentOffset.y
        //上移
        if imageOffsetY < 0 {
            let totalOffset:CGFloat = 160 + abs(imageOffsetY)
            if abs(imageOffsetY)>160 {
                return
            }
            self.headerImageViewTop.frame = CGRect(x:0,y:imageOffsetY,width: imageWeight,height:totalOffset)
        }
    }
}




