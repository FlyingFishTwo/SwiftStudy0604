//
//  BannerViewController.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/11.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON

class BannerViewController: UIViewController {
    

    //朋友圈数据源
    var dataArray = [KingCell_HeightModel]()
    
    // 轮播图数据源
    lazy var iconArray = {() -> [URL] in
        var darr = [URL]()
//        darr.append(URL(string: "https://ws1.sinaimg.cn/large/610dc034ly1fg5dany6uzj20u011iq60.jpg")!)
//        darr.append(URL(string: "https://ws1.sinaimg.cn/large/610dc034ly1ffyp4g2vwxj20u00tu77b.jpg")!)
//        darr.append(URL(string: "https://ws1.sinaimg.cn/large/610dc034ly1ffxjlvinj5j20u011igri.jpg")!)
//        darr.append(URL(string: "https://ws1.sinaimg.cn/mw690/610dc034ly1ffwb7npldpj20u00u076z.jpg")!)
//        darr.append(URL(string: "https://ws1.sinaimg.cn/large/610dc034ly1ffv3gxs37oj20u011i0vk.jpg")!)
//        darr.append(URL(string: "https://ws1.sinaimg.cn/large/d23c7564ly1fg6qckyqxkj20u00zmaf1.jpg")!)

        darr.append(URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1562945263&di=934d69df4541863ff7fdf623ed6eb622&src=http://pic24.nipic.com/20121008/10031483_145411002321_2.jpg")!)
        darr.append(URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1562945263&di=202006285d914f774fb491d07e52aca3&src=http://picture.ik123.com/uploads/allimg/170119/4-1F1191J342.jpg")!)
        darr.append(URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1562945263&di=5f089570a628e239aefd2752f71057ed&src=http://pic38.nipic.com/20140214/2572038_113009283000_2.jpg")!)
        darr.append(URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1562945263&di=8046ae264dd1e32fdb97bce1f2dfc9ad&src=http://pic19.nipic.com/20120310/8853864_130132914000_2.jpg")!)
        darr.append(URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1562945457&di=32590b08dacc0ff83fc3914ce54d89a1&src=http://pic22.nipic.com/20120627/387472_170953463126_2.jpg")!)
        darr.append(URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1562945457&di=65f8f08a3ab6cad71c7ecd49c0ade49c&src=http://pic27.nipic.com/20130126/10068494_204540170180_2.jpg")!)
        darr.append(URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1562945457&di=927360f1ed0c6ddf9085eeaad52ed6ff&src=http://pic1.nipic.com/2009-02-24/200922482815876_2.jpg")!)
        darr.append(URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1562945457&di=314e9651190eb756ece3548fbc487683&src=http://pic38.nipic.com/20140222/18047040_212020215155_2.jpg")!)

        return darr
    }()
    
    //懒加载轮播图View
    lazy var headerView:Banner_HeaderView = Banner_HeaderView(frame: CGRect(x: 0, y: 0, width: Configs.Dimensions.screenWidth, height: 160), dataArray: iconArray)
    
    //懒加载 tableView
    lazy var tableView:UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: Configs.Dimensions.screenWidth, height: Configs.Dimensions.screenHeight), style: .plain )
        table.delegate = self
        table.dataSource = self
        table.register(cellType: Banner_Cell.self)
        table.tableFooterView = UIView()

//        table.estimatedRowHeight = 50
//        table.rowHeight = 230
        table.tableHeaderView  = self.headerView
        return table
    }()



    override func viewDidLoad() {
        super.viewDidLoad()

        // 获取数据
        getDataWithBound()
        view.addSubview(tableView)
        

    }
    
}

// MARK: 代理协议  ---UITableViewDataSource,UITableViewDelegate
extension BannerViewController :UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: Banner_Cell.self)
        cell.king = dataArray[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //缓存的高度
        let model = dataArray[indexPath.row]
        return model.cellHeight ?? 0
    }

}



// MARK:  cell 的代理方法
extension BannerViewController : CloseClickBtnDelegate{
    
    func clickWithCell(cell: Banner_Cell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else{
            return
        }
        var model_Frame = dataArray[(indexPath.row)]
        guard var dataM = model_Frame.model else {
            return
        }
        
        dataM.isOpen = !dataM.isOpen
        model_Frame.model = dataM
        // 很重要，一定要把model  还给数据源
        dataArray[(indexPath.row)] = model_Frame
        UIView.performWithoutAnimation {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

}

// MARK:获取数据
extension BannerViewController {
    func getDataWithBound() {
        dataArray.removeAll()
        // 从 Bundle 中加载配置的 json
        guard let path = Bundle.main.path(forResource: "new_ImageData", ofType: "json"),
            let data = NSData(contentsOfFile: path) else {
                return
        }
        
        guard let json = try? JSON(data: data as Data) else { return }
        CWLog(json)
        let array = json["feed"]
        for (_,sub) in array {
            let cacheM_King = KingModel.init(jsonData: sub)
            let cellLayoutM = KingCell_HeightModel(model: cacheM_King)
            dataArray.append(cellLayoutM)
        }
        CWLog(dataArray)
        tableView.reloadData()
    }
    
    
}


