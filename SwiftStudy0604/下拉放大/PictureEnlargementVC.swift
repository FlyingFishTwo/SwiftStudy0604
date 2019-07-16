//
//  PictureEnlargementVC.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/16.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

let M_width = Configs.Dimensions.screenWidth
let CELLID = "CELLID"

class PictureEnlargementVC: UIViewController {

    
    lazy var tableView:UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height-88), style: .plain)
        table.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: CELLID)
        table.tableFooterView = UIView()
        return table
    }()

    var labels = ["QQ交流群", "微信公众号", "去评分", "用户协议", "iOS开发", "版本更新", "3G/4G", "非Wifi", ]
    var detialLabels = [ "1509159596", "grbank", "", "5个", "Alex", "V.1.0", "", ""]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "headerView测试";
        
        view.addSubview(tableView)
        // 添加header   这里的高度要根据图片的高度进行设定    否则cell可能会被图片遮挡（图片过大）
        let headFrame = CGRect(x: 0, y: 0, width: M_width, height: 282)
        tableView.wg_setHeaderView(frame: headFrame, image: UIImage(named: "headerImage"))

    }

}


// MARK: UITableViewDataSource
extension PictureEnlargementVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELLID, for: indexPath)
        cell.textLabel?.text = labels[indexPath.row]
        cell.detailTextLabel?.text = detialLabels[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("你点击了第\(indexPath.row)个cell")
        
    }

}


